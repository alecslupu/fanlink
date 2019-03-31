class AddUniqueFieldToCertificateCertcourse < ActiveRecord::Migration[5.1]
  def change
    add_index :certificate_certcourses, [:certcourse_id, :certificate_id], unique: true, name: :idx_uniq_cid_cid
  end
end
