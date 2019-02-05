class CreateApiKey < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.integer :person_id, null: false
      t.string :key, null: false
      t.string :secret, null: false
    end
  end
end
