class CreatePostPolls < ActiveRecord::Migration[5.1]
  def change
    create_table :post_polls do |t|
      t.text :description, null: false

      t.timestamps
    end
  end
end
