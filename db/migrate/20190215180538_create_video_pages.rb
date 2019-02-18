class CreateVideoPages < ActiveRecord::Migration[5.1]
  def change
    create_table :video_pages do |t|
      t.integer :certcourse_page_id
      t.string :video_url, default: "", null: false

      t.timestamps
    end
    add_index :video_pages, %i[ certcourse_page_id ], name: "idx_video_pages_certcourse_page"
    add_foreign_key :video_pages, :certcourse_pages, name: "fk_video_pages_certcourse_page"
  end
end
