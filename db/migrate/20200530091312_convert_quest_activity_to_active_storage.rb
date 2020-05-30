class ConvertQuestActivityToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    QuestActivity.where.not(picture_file_name: nil).find_each do |quest|
      Migration::Assets::QuestActivityJob.perform_later(quest.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
