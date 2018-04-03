class AddRecommendedToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :recommended, :boolean, default: false, null: false
  end
end
