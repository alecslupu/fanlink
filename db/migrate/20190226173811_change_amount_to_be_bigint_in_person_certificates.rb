class ChangeAmountToBeBigintInPersonCertificates < ActiveRecord::Migration[5.1]
  def up
  	change_column :person_certificates, :amount_paid, :bigint
  end

  def down
  	change_column :person_certificates, :amount_paid, :integer
  end
end
