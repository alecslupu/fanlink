class AddPriorityToMerchandise < ActiveRecord::Migration[5.1]
  def change
    add_column :merchandise, :priority, :integer, default: 0, null: false
    add_index :merchandise, %i[ product_id priority], name: "idx_merchandise_product_priority"
  end
end
