class CreateRelationships < ActiveRecord::Migration[5.1]
  def up
    create_table :relationships do |t|
      t.integer :requested_by_id, null: false
      t.integer :requested_to_id, null: false
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_index :relationships, [:requested_by_id], name: "idx_relationships_requested_by_id"
    add_index :relationships, [:requested_to_id], name: "idx_relationships_requested_to_id"
    add_foreign_key :relationships, :people, column: :requested_by_id, name: "fk_relationships_requested_by", on_delete: :cascade
    add_foreign_key :relationships, :people, column: :requested_to_id, name: "fk_relationships_requested_to", on_delete: :cascade
    add_check "relationships", "(requested_by_id != requested_to_id)", name: "chk_relationships_not_with_self"


    Relationship.where("status > ?", 1).destroy_all
    add_index :relationships, %i[ requested_by_id requested_to_id ], unique: true, name: "unq_relationships_requested_by_requested_to"
  end

  def down
    drop_table :relationships
  end
end
