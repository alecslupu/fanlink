class AddCanHaveSuperToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :can_have_supers, :boolean, default: false, null: false
  end
end
