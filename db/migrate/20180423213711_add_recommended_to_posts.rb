class AddRecommendedToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :recommended, :boolean, default: false, null: false
    add_index :posts, :recommended, where: "recommended = true"
  end
end
