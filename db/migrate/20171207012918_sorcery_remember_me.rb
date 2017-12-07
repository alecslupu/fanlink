class SorceryRememberMe < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :remember_me_token, :string, :default => nil
    add_column :people, :remember_me_token_expires_at, :datetime, :default => nil

    add_index :people, :remember_me_token, name: "ind_people_remember_me_token"
  end
end
