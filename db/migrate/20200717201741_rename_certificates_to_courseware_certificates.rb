class RenameCertificatesToCoursewareCertificates < ActiveRecord::Migration[6.0]
  def up
    rename_table :certificates, :courseware_certificates
  end

  def down
    rename_table :courseware_certificates, :certificates
  end
end
