class CreateActivityType < ActiveRecord::Migration[5.1]
  def up
    create_table :activity_types do |t|
      t.integer :activity_id, null: false
      t.text :type, null: false
      t.jsonb :value, null: false
    end
    add_index :activity_types, :activity_id, name: "ind_activity_id"
    add_foreign_key :activity_types, :quest_activities, column: "activity_id", name: "fk_activity_types_quest_activities"
    rename_column :activity_types, :type, :atype
    change_column :activity_types, :value, :jsonb, :default => {}, null: false
    add_column :activity_types, :deleted, :boolean, default: false, null: false

    add_column :activity_types, :created_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :activity_types, :updated_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }

    rename_column :activity_types, :atype, :atype_old
    add_column :activity_types, :atype, :integer, default: 0, null: false
    #enum atype: %i[ beacon image audio post activity_code ]
    ActivityType.all.each do |at|
      if at.atype_old.present?
        if at.atype_old == "beacon"
          at.atype = 0
          at.save
        elsif at.atype_old == "image"
          at.atype = 1
          at.save
        elsif at.atype_old == "audio"
          at.atype = 2
          at.save
        elsif at.atype_old == "post"
          at.atype = 3
          at.save
        elsif at.atype_old == "activity_code"
          at.atype = 4
          at.save
        end
      end
    end
    change_column_null :activity_types, :atype_old, true, 1

  end

  def down
    drop_table :activity_types
  end
end
