class PostMessageJob < Struct.new(:message_id)
  include RealTimeHelpers

  def perform
    message = Message.find(message_id)
    ActsAsTenant.with_tenant(message.room.product) do
      if message.room.public?
        msg = {
          id: message.id,
          body: message.parse_content(),
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
        if message.mention_meta.length > 0
          msg[:message_mentions] = message.mention_meta.map do |mention|
            mention
          end
        else
          msg[:message_mentions] = nil
        end
        # msg = ApiController.render(
        #   template: "api/v4/messages/show",
        #   assigns: {message: message},
        #   handlers: "jb"
        # )
        Rails.logger.debug(msg)
        res = client.set("#{room_path(message.room)}/last_message", msg)
        Rails.logger.debug(res)
      else
        client.set("#{room_path(message.room)}/last_message_id", message.id)
      end
    end
  end

  def error(job, exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      job.destroy
    end
  end
end
