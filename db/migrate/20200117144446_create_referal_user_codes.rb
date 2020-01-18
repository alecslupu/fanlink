class CreateReferalUserCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :referal_user_codes do |t|
      t.references :person, foreign_key: true
      t.string :unique_code

      t.timestamps
    end
    add_index :referal_user_codes, :unique_code, unique: true
  end
end
