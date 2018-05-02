class RemovePersonFromPortalNotifications < ActiveRecord::Migration[5.1]
  def up
    remove_column :portal_notifications, :person_id
  end
  def down
    add_column :portal_notifications, :person_id, :integer
    add_foreign_key :portal_notifications, :people, name: "fk_portal_notifications_people", on_delete: :restrict
  end
end
