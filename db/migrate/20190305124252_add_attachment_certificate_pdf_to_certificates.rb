class AddAttachmentCertificatePdfToCertificates < ActiveRecord::Migration[5.1]
  def self.up
    change_table :certificates do |t|
      t.attachment :template_image
    end
  end

  def self.down
    remove_attachment :certificates, :template_image
  end
end