class UniqueRelationships < ActiveRecord::Migration[5.1]
  def up
    Relationship.where("status > ?", 1).destroy_all
    add_index :relationships, %i[ requested_by_id requested_to_id ], unique: true, name: "unq_relationships_requested_by_requested_to"
  end

  def down
    remove_index :relationships, name: "unq_relationships_requested_by_requested_to"
  end
end
