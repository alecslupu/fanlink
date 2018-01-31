class AddAutoFollowToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :auto_follow, :boolean, default: false, null: false
    add_index :people, %i[ product_id auto_follow ], name: "idx_people_product_auto_follow"
  end
end
