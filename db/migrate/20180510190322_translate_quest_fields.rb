class TranslateQuestFields < ActiveRecord::Migration[5.1]
  def change
    rename_column :quests, :name, :name_text_old
    rename_column :quests, :description, :description_text_old

    change_column_null :quests, :name_text_old, true
    change_column_null :quests, :description_text_old, true

    add_column :quests, :name, :jsonb, default: {}, null: false
    add_column :quests, :description, :jsonb, default: {}, null: false

    Quest.all.each do |q|
      unless q.name_text_old.nil?
        q.name = q.name_text_old
      end
      unless q.description_text_old.nil?
        q.description = q.description_text_old
      end
      q.save
    end
  end
end
