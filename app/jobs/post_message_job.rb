class PostMessageJob < Struct.new(:message_id, :version)
  include RealTimeHelpers

  def perform
    message = Message.find(message_id)
    Rails.logger.tagged("Post Message Job") { Rails.logger.debug "Running PostMessageJob" } unless Rails.env.production?
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
          Rails.logger.tagged("Post Message Job") { Rails.logger.debug "Message #{message.id} created. Pushing message to version: #{version} path: #{versioned_room_path(message.room, version)}/last_message" } unless Rails.env.production?
          version.downto(1) { |v|
            response = client.set("#{versioned_room_path(message.room, v)}/last_message", msg)
            Rails.logger.tagged("Post Message Job #{v}") { Rails.logger.debug response.inspect } unless Rails.env.production?
          }
        end
        client.set("#{room_path(message.room)}/last_message_id", message.id) # Remove with V5
      else
        client.set("#{room_path(message.room)}/last_message_id", message.id)
        if version.present?
          version.downto(1) { |v|
            client.set("#{versioned_room_path(message.room, v)}/last_message_id", message.id)
          }
        end
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end

  def queue_name
    :default
  end
end
