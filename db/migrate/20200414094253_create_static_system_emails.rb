class CreateStaticSystemEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :static_system_emails do |t|
      t.string :name
      t.references :product, foreign_key: true
      t.boolean :public, default: false
      t.string :from_name
      t.string :from_email
      t.string :slug

      t.timestamps
    end
    add_index :static_system_emails, [:slug, :product_id], unique: true
  end
end
