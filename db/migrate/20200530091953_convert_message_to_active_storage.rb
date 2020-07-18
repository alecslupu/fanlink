class ConvertMessageToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    Message.where.not(picture_file_name: nil).find_each do |message|
      Migration::Assets::MessageJob.perform_later(message.id, "picture")
    end
    Message.where.not(audio_file_name: nil).find_each do |message|
      Migration::Assets::MessageJob.perform_later(message.id, "audio")
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
