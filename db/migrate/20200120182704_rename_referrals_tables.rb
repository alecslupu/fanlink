class RenameReferralsTables < ActiveRecord::Migration[5.1]
  def up
    rename_table :referal_user_codes, :referral_user_codes
    rename_table :referal_refered_people, :referral_referred_people
  end

  def down
    rename_table :referral_user_codes, :referal_user_codes
    rename_table :referral_referred_people, :referal_refered_people
  end
end
