class CreateVideoPages < ActiveRecord::Migration[5.1]
  def change
    create_table :video_pages do |t|
      t.references :certcourse_page, foreign_key: true
      t.string :video_url, default: "", null: false

      t.timestamps
    end
    add_index :video_pages, %i[ certcourse_page ], name: "idx_video_page_certcourse_page"
  end
end
