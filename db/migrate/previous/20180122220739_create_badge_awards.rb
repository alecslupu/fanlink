class CreateBadgeAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :badge_awards do |t|
      t.integer :person_id, null: false
      t.integer :badge_id, null: false
      t.timestamps null: false
    end
    add_index :badge_awards, %i[ person_id badge_id], unique: true, name: "unq_badge_awards_people_badges"
  end

  def down
    drop_table :badge_awards
  end
end
