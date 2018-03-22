class AddLevelNameTranslation < ActiveRecord::Migration[5.1]
  def up
    rename_column :levels, :name, :name_text_old
    change_column_null :levels, :name_text_old, true
    add_column :levels, :name, :jsonb, default: {}, null: false

    Level.all.each do |l|
      if l.name_text_old.present?
        l.name = l.name_text_old
        l.save
      end
    end
  end

  def down
    remove_column :levels, :name
    rename_column :levels, :name_text_old, :name
  end
end
