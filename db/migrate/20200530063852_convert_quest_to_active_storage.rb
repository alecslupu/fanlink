class ConvertQuestToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    Quest.where.not(picture_file_name: nil).find_each do |quest|
      Migration::Assets::QuestJob.perform_later(quest.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
