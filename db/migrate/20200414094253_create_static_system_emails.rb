class CreateStaticSystemEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :static_system_emails do |t|
      t.string :name
      t.references :product, foreign_key: true
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
