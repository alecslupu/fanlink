class AddAttachmentAudioToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :messages, :audio
  end
end
