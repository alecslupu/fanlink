class RenamePersonCertificates < ActiveRecord::Migration[6.0]
  def up
    if table_exists?(:person_certificates)
      rename_table :person_certificates, :courseware_person_certificates
    end
  end

  def down
    if table_exists?(:courseware_person_certificates)
      rename_table :courseware_person_certificates, :person_certificates
    end
  end
end
