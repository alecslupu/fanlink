class DontRememberMe < ActiveRecord::Migration[5.1]
  def up
  end

  def down
    add_column :people, :remember_me_token, :string
    add_column :people, :remember_me_token_expires_at, :datetime
    add_index :people, [:remember_me_token], name: "ind_people_remember_me_token"
  end
end
