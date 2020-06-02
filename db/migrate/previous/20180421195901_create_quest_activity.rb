class CreateQuestActivity < ActiveRecord::Migration[5.1]
  def up
    create_table :quest_activities do |t|
      t.integer :quest_id, null: false
      t.text :description
      t.text :hint
      t.boolean :post
      t.boolean :image
      t.boolean :audio
      t.text :requires
      t.boolean :deleted, default: false
    end
    add_index :quest_activities, [:quest_id], name: "ind_activity_quest"
    add_foreign_key :quest_activities, :quests, name: "fk_activities_quests"
    rename_column :quest_activities, :requires, :beacon
    add_column :quest_activities, :step, :integer
    add_column :quest_activities, :activity_code, :integer

    change_column_default :quest_activities, :image, false
    change_column_default :quest_activities, :post, false
    change_column_default :quest_activities, :audio, false

    change_column :quest_activities, :activity_code, :string, :default => nil
    add_attachment :quest_activities, :picture
    add_column :quest_activities, :picture_meta, :text

    rename_column :quest_activities, :hint, :hint_text_old
    rename_column :quest_activities, :description, :description_text_old

    change_column_null :quest_activities, :hint_text_old, true
    change_column_null :quest_activities, :description_text_old, true

    add_column :quest_activities, :hint, :jsonb, default: {}, null: false
    add_column :quest_activities, :description, :jsonb, default: {}, null: false

    QuestActivity.all.each do |qa|
      unless qa.hint_text_old.nil?
        qa.hint = qa.hint_text_old
      end
      unless qa.description_text_old.nil?
        qa.description = qa.description_text_old
      end
      qa.save
    end
    change_column_null :quest_activities, :step, false
    change_column :quest_activities, :beacon, 'integer USING CAST(beacon AS integer)', unique: true

    QuestActivity.all.each do |qa|
      unless qa.beacon.is_a? Numeric
        qa.beacon = qa.id
      end
    end
    add_column :quest_activities, :created_at, :datetime, default: nil, null: false
    add_column :quest_activities, :updated_at, :datetime, default: nil, null: false
    QuestActivity.update_all({:created_at => Time.now, :updated_at => Time.now})
    add_column :quest_activities, :step_id, :integer, null: false
    remove_foreign_key :quest_activities, name: "fk_activities_quests"
    add_foreign_key :quest_activities, :steps, name: "fk_activities_steps"

    remove_column :quest_activities, :step
    remove_column :quest_activities, :beacon
    remove_column :quest_activities, :post
    remove_column :quest_activities, :image
    remove_column :quest_activities, :audio
  end

  def down
    drop_table :quest_activities
  end
end



