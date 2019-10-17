class CreateConfigItems < ActiveRecord::Migration[5.1]
  def change
    create_table :config_items do |t|
      t.belongs_to :product, foreign_key: true
      t.string :item_key
      t.string :item_value
      t.string :type
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
