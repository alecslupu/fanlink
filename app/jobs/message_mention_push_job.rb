# frozen_string_literal: true

class MessageMentionPushJob < ApplicationJob
  queue_as :default
  include Push

  def perform(message_mention_id)
    message_mention = MessageMention.find(message_mention_id)
    ActsAsTenant.with_tenant(message_mention.message.room.product) do
      if message_mention.message.room.public?
        message_mention_push(message_mention.message, message_mention.person)
      end
    end
  end
end
