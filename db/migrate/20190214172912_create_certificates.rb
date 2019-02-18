class CreateCertificates < ActiveRecord::Migration[5.1]
  def change
    create_table :certificates do |t|
      t.string :long_name, null: false
      t.string :short_name, null: false
      t.text :description, default: "", null: false
      t.integer :order, null: false
      t.string :color_hex, default: "#000000", null: false
      t.integer :status, default: 0, null: false
      t.references :room, foreign_key: true
      t.boolean :is_free, default: false
      t.string :sku_ios, default: "", null: false
      t.string :sku_android, default: "", null: false
      t.integer :validity_duration, default: 0, null: false
      t.integer :access_duration, default: 0, null: false
      t.string :template_image_url
      t.boolean :certificate_issuable, default: false

      t.timestamps
    end
  end
end
