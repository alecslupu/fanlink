class CreateReferalReferedPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :referal_refered_people do |t|
      t.belongs_to :inviter, index: true
      t.belongs_to :invited, index: true
      t.timestamps
    end

    add_foreign_key :referal_refered_people, :people, column: :inviter_id
    add_foreign_key :referal_refered_people, :people, column: :invited_id
  end
end
