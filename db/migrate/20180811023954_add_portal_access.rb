class AddPortalAccess < ActiveRecord::Migration[5.1]
  def change
    create_table :portal_accesses do |t|
      t.integer :person_id, null: false
      t.integer :post, :null => false, :default => 0
      t.integer :chat, :null => false, :default => 0
      t.integer :event, :null => false, :default => 0
      t.integer :merchandise, :null => false, :default => 0
      t.integer :user, :null => false, :default => 0
      t.integer :badge, :null => false, :default => 0
      t.integer :reward, :null => false, :default => 0
      t.integer :quest, :null => false, :default => 0
      t.integer :beacon, :null => false, :default => 0
      t.integer :reporting, :null => false, :default => 0
    end
    add_foreign_key :messages, :people, name: "fk_portal_access_people", on_delete: :cascade
  end
end
