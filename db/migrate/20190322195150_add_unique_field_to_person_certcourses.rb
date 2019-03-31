class AddUniqueFieldToPersonCertcourses < ActiveRecord::Migration[5.1]
  def change
    add_index :person_certcourses,  [:person_id, :certcourse_id], unique: true, name: :idx_uniq_pc_pid_cid2
  end
end
1
