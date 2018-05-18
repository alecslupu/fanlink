class CreateStepCompleted < ActiveRecord::Migration[5.1]
  def change
    create_table :step_completed do |t|
      t.integer :step_id, null: false
      t.integer :person_id, null: false
      t.text :status, default: 0, null: false
    end
  end
end
