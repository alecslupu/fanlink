class AddTranslatedMerchFields < ActiveRecord::Migration[5.1]
  def up
    rename_column :merchandise, :name, :name_text_old
    change_column_null :merchandise, :name_text_old, true
    rename_column :merchandise, :description, :description_text_old
    add_column :merchandise, :name, :jsonb, default: {}, null: false
    add_column :merchandise, :description, :jsonb, default: {}, null: false

    Merchandise.all.each do |m|
      if m.name_text_old.present?
        m.name = m.name_text_old
      end
      if m.description_text_old.present?
        m.description = m.description_text_old
      end
      m.save
    end
  end

  def down
    remove_column :merchandise, :name
    rename_column :merchandise, :name_text_old, :name
    remove_column :merchandise, :description
    rename_column :merchandise, :description_text_old, :description
  end
end
