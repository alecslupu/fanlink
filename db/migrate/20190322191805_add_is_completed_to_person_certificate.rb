class AddIsCompletedToPersonCertificate < ActiveRecord::Migration[5.1]
  def change
    add_column :person_certificates, :is_completed, :boolean, default: false
  end
end
