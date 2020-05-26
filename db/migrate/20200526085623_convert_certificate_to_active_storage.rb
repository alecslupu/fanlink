class ConvertCertificateToActiveStorage < ActiveRecord::Migration[5.2]
  def up
    Certificate.where.not(template_image_file_name: nil).find_each do |badge|
      Migration::Assets::CertificateJob.perform_later(badge.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
