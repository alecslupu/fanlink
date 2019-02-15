class CreateCertificates < ActiveRecord::Migration[5.1]
  def change
    create_table :certificates do |t|
      t.string :long_name, null: false
      t.string :short_name, null: false
      t.jsonb :description, default: {}, null: false
      t.integer :order, null: false
      t.string :color_text
      t.integer :status, default: 0, null: false
      t.references :room, foreign_key: true
      t.boolean :is_free, default: false
      t.string :sku_ios
      t.string :sku_android 
      t.integer :validity_duration, default:0, null: false
      t.integer :access_duration, default: 0, null: false
      t.string :certificate_url, default: "" ,null: false
      t.boolean :certificate_issued, default: false
      t.string :unique_id, null: false

      t.timestamps
    end
  end
end
