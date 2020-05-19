# frozen_string_literal: true
class PostMessageJob < ApplicationJob
  queue_as :default
  include RealTimeHelpers

  def perform(message_id, version = 0)
    message = Message.find(message_id)
    ActsAsTenant.with_tenant(message.room.product) do
      if message.room.public?
        msg = {
          id: message.id,
          room_id: message.room_id,
          body: message.parse_content(version.presence || 0),
          # picture_id: message.picture_id,
          create_time: message.create_time,
          picture_url: message.picture_url,
          pinned: message.pinned,
          person: {
            id: message.person.id,
            username: message.person.username,
            name: message.person.name,
            designation: message.person.designation,
            product_account: message.person.product_account,
            chat_banned: message.person.chat_banned,
            badge_points: message.person.badge_points,
            level: message.person.level,
            picture_url: message.person.picture_url
          }
        }
        if version.present?
          version.downto(1) do |v|
            client.set("#{versioned_room_path(message.room, v)}/last_message", msg)
          end
        end
        client.set("#{room_path(message.room)}/last_message_id", message.id) # Remove with V5
      else
        client.set("#{room_path(message.room)}/last_message_id", message.id)
        if version.present?
          version.downto(1) do |v|
            client.set("#{versioned_room_path(message.room, v)}/last_message_id", message.id)
          end
        end
      end
    end
  end
end
