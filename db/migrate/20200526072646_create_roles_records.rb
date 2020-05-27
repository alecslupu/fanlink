class CreateRolesRecords < ActiveRecord::Migration[5.2]
  def up
    unless Role.where(internal_name: "normal").exists?
    Role.create(name: "Normal",
                internal_name: "normal",
                post: 0,
                chat: 0,
                event: 0,
                merchandise: 0,
                badge: 0,
                reward: 0,
                quest: 0,
                beacon: 0,
                reporting: 0,
                interest: 0,
                courseware: 0,
                trivia: 0,
                admin: 0,
                root: 0,
                user: 0,
                portal_notification: 0,
                automated_notification: 0,
                marketing_notification: 0
          )
    end

    unless Role.where(internal_name: "staff").exists?
      Role.create(
        name: "Staff",
        internal_name: "staff",
        post: 0,
        chat: 0,
        event: 0,
        merchandise: 0,
        badge: 0,
        reward: 0,
        quest: 0,
        beacon: 0,
        reporting: 0,
        interest: 0,
        courseware: 0,
        trivia: 0,
        admin: 0,
        root: 0,
        user: 0,
        portal_notification: 0,
        automated_notification: 0,
        marketing_notification: 0
      )
    end
    unless Role.where(internal_name: "client_portal").exists?
      Role.create(
        name: "Client Portal",
        internal_name: "client_portal",
        post: 0,
        chat: 0,
        event: 0,
        merchandise: 0,
        badge: 0,
        reward: 0,
        quest: 0,
        beacon: 0,
        reporting: 0,
        interest: 0,
        courseware: 0,
        trivia: 0,
        admin: 0,
        root: 0,
        user: 11,
        portal_notification: 0,
        automated_notification: 0,
        marketing_notification: 0
      )
    end
    unless Role.where(internal_name: "client").exists?
      Role.create(
        name: "Client",
        internal_name: "client",
        post: 0,
        chat: 0,
        event: 0,
        merchandise: 0,
        badge: 0,
        reward: 0,
        quest: 0,
        beacon: 0,
        reporting: 0,
        interest: 0,
        courseware: 0,
        trivia: 0,
        admin: 0,
        root: 0,
        user: 0,
        portal_notification: 0,
        automated_notification: 0,
        marketing_notification: 0
      )
    end
    unless Role.where(internal_name: "root").exists?
      Role.create(
        name: "God",
        internal_name: "root",
        post: 31,
        chat: 127,
        event: 31,
        merchandise: 31,
        badge: 31,
        reward: 31,
        quest: 31,
        beacon: 31,
        reporting: 31,
        interest: 31,
        courseware: 127,
        trivia: 63,
        admin: 31,
        root: 31,
        user: 31,
        portal_notification: 31,
        automated_notification: 31,
        marketing_notification: 31
      )
    end
    unless Role.where(internal_name: "super_admin").exists?
      Role.create(
        name: "Super Admin",
        internal_name: "super_admin",
        post: 127,
        chat: 127,
        event: 31,
        merchandise: 31,
        badge: 31,
        reward: 31,
        quest: 31,
        beacon: 31,
        reporting: 31,
        interest: 31,
        courseware: 127,
        trivia: 63,
        admin: 31,
        root: 0,
        user: 31,
        portal_notification: 31,
        automated_notification: 31,
        marketing_notification: 31
      )
    end
    unless Role.where(internal_name: "marketingrole").exists?
      Role.create(
        name: "Marketing_role",
        internal_name: "marketingrole",
        post: 0,
        chat: 0,
        event: 0,
        merchandise: 0,
        badge: 0,
        reward: 0,
        quest: 0,
        beacon: 0,
        reporting: 0,
        interest: 0,
        courseware: 0,
        trivia: 0,
        admin: 0,
        root: 0,
        user: 0,
        portal_notification: 0,
        automated_notification: 31,
        marketing_notification: 31
      )
    end
    unless Role.where(internal_name: "admin").exists?
      Role.create(
        name: "Admin",
        internal_name: "admin",
        post: 127,
        chat: 127,
        event: 31,
        merchandise: 0,
        badge: 31,
        reward: 31,
        quest: 0,
        beacon: 0,
        reporting: 31,
        interest: 31,
        courseware: 127,
        trivia: 63,
        admin: 0,
        root: 0,
        user: 31,
        portal_notification: 0,
        automated_notification: 31,
        marketing_notification: 31
      )
    end
    Role.find_each do |role|
      Person.where(old_role: role.internal_name).update_all(role_id: role.id)
    end
  end

  def down
  end
end
