class AddResetPasswordFieldsToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :reset_password_token, :text
    add_column :people, :reset_password_token_expires_at, :datetime
    add_column :people, :reset_password_email_sent_at, :datetime
  end
end
