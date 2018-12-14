class TranslateQuestActivityFields < ActiveRecord::Migration[5.1]
  def change
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
  end
end
