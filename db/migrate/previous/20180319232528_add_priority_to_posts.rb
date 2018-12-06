class AddPriorityToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :priority, :integer, default: 0, null: false
    add_index :posts, %i[ person_id priority], name: "idx_posts_person_priority"
  end
end
