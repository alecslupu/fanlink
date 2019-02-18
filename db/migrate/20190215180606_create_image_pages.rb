class CreateImagePages < ActiveRecord::Migration[5.1]
  def change
    create_table :image_pages do |t|
      t.integer :certcourse_page_id
      t.string :image_url, default: "", null: false

      t.timestamps
    end
    add_index :image_pages, %i[ certcourse_page_id ], name: "idx_image_pages_certcourse_page"
    add_foreign_key :image_pages, :certcourse_pages, name: "fk_image_pages_certcourse_page"
  end
end
