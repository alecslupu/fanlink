class CreateBadgeProgress < ActiveRecord::Migration[5.1]
  def change
    create_table :badge_progresses do |t|
    t.integer :person_id, null: false
    t.integer :badge_id, null: false
    t.integer :qearned_actions, default: 0, null: false
    t.integer :nqearned_actions, default: 0, null: false
    t.integer :granted_actions, default: 0, null: false
    t.integer :total, default: 0, null: false
    end
  end
end
