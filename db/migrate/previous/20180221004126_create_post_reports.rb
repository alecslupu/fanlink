class CreatePostReports < ActiveRecord::Migration[5.1]
  def change
    create_table :post_reports do |t|
      t.integer :post_id, null: false
      t.integer :person_id, null: false
      t.text :reason
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_index :post_reports, %i[ post_id ], name: "idx_post_reports_post"
    add_foreign_key :post_reports, :posts, name: "fk_post_reports_post", on_delete: :cascade
    add_foreign_key :post_reports, :people, name: "fk_post_reports_people", on_delete: :cascade
  end
end
