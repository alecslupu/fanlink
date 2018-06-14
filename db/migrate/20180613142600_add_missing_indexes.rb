class AddMissingIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :badges, :action_type_id
    add_index :badges, :product_id
    add_index :message_mentions, :person_id
    add_index :message_reports, :message_id
    add_index :message_reports, :person_id
    add_index :messages, :person_id
    add_index :post_comment_mentions, :person_id
    add_index :post_comment_reports, :person_id
    add_index :post_comments, :person_id
    add_index :post_reports, :person_id
    add_index :quest_activities, :step_id
    add_index :quest_completed, :person_id
    add_index :quest_completed, :quest_id
    add_index :quest_completions, :activity_id
    add_index :rooms, :created_by_id
    add_index :steps, :quest_id
  end
end
