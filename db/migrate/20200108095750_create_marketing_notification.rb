class CreateMarketingNotification < ActiveRecord::Migration[5.1]
  def change
    create_table :marketing_notifications do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :person, foreign_key: true, index: true, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
