class FacebookPersonChanges < ActiveRecord::Migration[5.1]
  def up
    add_column :people, :facebookid, :text
    change_column :people, :email, :text, null: true
    add_index :people, [:product_id, :facebookid], name: "unq_people_product_facebook", unique: true
  end
  def down
    remove_column :people, :facebookid
  end
end
