class CreateStep < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.integer :quest_id, null: false
      t.integer :prereq_step, default: nil
      t.text :display, default: nil
      t.boolean :deleted, default: false, null: false
      t.timestamps null: false
    end
    add_index :steps, :prereq_step, name: "idx_prerequisite_steps", where: "(prereq_step IS NOT NULL)"
    add_foreign_key :steps, :quests, name: "fk_steps_quests"
  end
end
