class AddAttachmentAudioToMessages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :messages do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :messages, :audio
  end
end
