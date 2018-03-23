class AddTranslatedBadgeFields < ActiveRecord::Migration[5.1]
  def up
    rename_column :badges, :name, :name_text_old
    change_column_null :badges, :name_text_old, true
    rename_column :badges, :description, :description_text_old
    change_column_null :badges, :description_text_old, true
    add_column :badges, :name, :jsonb, default: {}, null: false
    add_column :badges, :description, :jsonb, default: {}, null: false

    Badge.all.each do |b|
      unless b.name_text_old.nil?
        b.name = b.name_text_old
      end
      unless b.description_text_old.nil?
        b.description = b.description_text_old
      end
      b.save
    end
  end

  def down
    remove_column :badges, :name
    rename_column :badges, :name_text_old, :name
    remove_column :badges, :description
    rename_column :badges, :description_text_old, :description
  end
end
