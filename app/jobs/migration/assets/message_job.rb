module Migration
  module Assets
    class MessageJob < ::Migration::Assets::ApplicationJob
      def perform(product_id, what)
        require 'open-uri'
        message = ::Message.find(product_id)
        if what == "picture"
          url = paperclip_asset_url(message, "picture", message.room.product)
          message.picture.attach(io: open(url), filename: message.picture_file_name, content_type: message.picture_content_type)
        else
          url = paperclip_asset_url(message, "audio", message.room.product)
          message.audio.attach(io: open(url), filename: message.audio_file_name, content_type: message.audio_content_type)
        end
      end
    end

  end
end
