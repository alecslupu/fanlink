class CreateClientInfo < ActiveRecord::Migration[5.1]
  def change
    create_table :client_infos do |t|
      t.integer :client_id, null: false
      t.string :code, null: false

      t.timestamps
    end
    add_index :client_infos, :client_id
    add_index :client_infos, :code
  end

  def self.down
    drop_table :client_infos
  end
end
