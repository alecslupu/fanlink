class CreateAutomatedNotification < ActiveRecord::Migration[5.1]
  def change
    create_table :automated_notifications do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :person, foreign_key: true, null: false
      t.integer :criteria, index: true, null: false
      t.boolean :enabled, null: false, default: false
      t.integer :product_id, null: false
      t.datetime :last_sent_at

      t.timestamps
    end
  end
end
