class AddIdentifierToBadgeActions < ActiveRecord::Migration[5.1]
  def change
    add_column :badge_actions, :identifier, :text
    add_index(:badge_actions, %i[ person_id action_type_id identifier ],
                unique: true,
                name: "unq_badge_action_person_action_type_identifier",
                where: "identifier is NOT NULL")
  end
end
