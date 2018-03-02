class AddSomeForeignKeys < ActiveRecord::Migration[5.1]
  def up
    add_foreign_key :badge_actions, :action_types, name: "fk_badge_actions_action_types", on_delete: :restrict
    add_foreign_key :badge_actions, :people, name: "fk_badge_actions_people", on_delete: :cascade
    add_foreign_key :badge_awards, :people, name: "fk_badge_awards_people", on_delete: :cascade
    add_foreign_key :badge_awards, :badges, name: "fk_badge_awards_badges", on_delete: :restrict
    add_foreign_key :badges, :products, name: "fk_badges_products", on_delete: :cascade
    add_foreign_key :message_reports, :people, name: "fk_message_reports_people", on_delete: :restrict
  end

  def down
    remove_foreign_key :badge_actions, name: "fk_badge_actions_action_types"
    remove_foreign_key :badge_actions, name: "fk_badge_actions_people"
    remove_foreign_key :badge_awards, name: "fk_badge_awards_people"
    remove_foreign_key :badge_awards, name: "fk_badge_awards_badges"
    remove_foreign_key :badges, name: "fk_badges_products"
    remove_foreign_key :message_reports, name: "fk_message_reports_people"
  end
end
