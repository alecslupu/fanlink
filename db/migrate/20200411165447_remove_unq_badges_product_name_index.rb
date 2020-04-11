class RemoveUnqBadgesProductNameIndex < ActiveRecord::Migration[5.2]
  def up
    remove_index :badges, name: :unq_badges_product_name
    remove_index :rewards, name: :unq_rewards_product_name
  end
  def down
    add_index :badges, [:product_id, :untranslated_name], name: "unq_badges_product_name", unique: true
    add_index :rewards, [:product_id, :untranslated_name], name: "unq_rewards_product_name", unique: true

  end
end
