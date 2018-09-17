class AddMoreMissingIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :categories, :product_id
    add_index :contests, :product_id
    add_index :coupons, :product_id
    add_index :courses, :semester_id
    add_index :lessons, :course_id
    add_index :level_progresses, :person_id
    add_index :person_rewards, [:person_id, :reward_id]
    add_index :portal_accesses, :person_id
    add_index :posts, :category_id
    add_index :reward_progresses, :person_id
    add_index :reward_progresses, :reward_id
    add_index :semesters, :product_id
    add_index :step_unlocks, :step_id
    add_index :step_unlocks, [:step_id, :unlock_id]
    add_index :urls, :product_id
    add_index :messages, :body
    add_index :people, [:product_id, :username]
    add_index :people, [:product_id, :email]
    add_index :posts, :body, using: :gin
    add_index :posts, :status
    add_index :post_comments, :body
    add_index :post_comment_reports, :status
    add_index :post_reports, :status
    add_index :quests, :status
    add_index :quests, [:product_id, :internal_name]
    add_index :quests, :name, using: :gin
    add_index :quests, :description, using: :gin
    add_index :quests, :starts_at
    add_index :quests, :ends_at, where: "(ends_at IS NOT NULL)"
    add_index :quests, :created_at
    add_index :rewards, :series, where: "(series IS NOT NULL)"
  end
end
