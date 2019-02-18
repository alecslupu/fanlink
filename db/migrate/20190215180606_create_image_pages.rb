class CreateImagePages < ActiveRecord::Migration[5.1]
  def change
    create_table :image_pages do |t|
      t.references :certcourse_page, foreign_key: true
      t.string :video_url, default: "", null: false

      t.timestamps
    end
    add_index :image_pages, %i[ certcourse_page ], name: "idx_image_page_certcourse_page"
  end
end
