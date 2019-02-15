class CreateVideoPages < ActiveRecord::Migration[5.1]
  def change
    create_table :video_pages do |t|
      t.references :certcourse_page, foreign_key: true
      t.string :video_url, default: "", null: false

      t.timestamps
    end
  end
end
