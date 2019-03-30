class AddUniqueFieldToPersonCertificate < ActiveRecord::Migration[5.1]
  def change
    add_index :person_certificates,  [:person_id, :certificate_id], unique: true, name: :idx_uniq_pc_pid_cid
  end
end
