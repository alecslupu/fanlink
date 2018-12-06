class CreateLevelProgress < ActiveRecord::Migration[5.1]
  def change
    create_table :level_progresses do |t|
      t.integer :person_id, null: false
      t.jsonb :points, default: {}, null: false
      t.integer :total, default: 0, null: false
    end
  end
end
