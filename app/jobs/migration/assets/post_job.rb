module Migration
  module Assets
    class PostJob < ::Migration::Assets::ApplicationJob
      def perform(post_id, what)
        require 'open-uri'
        message = ::Post.find(post_id)

        url = paperclip_asset_url(message, what, post.product)
        case what
        when "picture"
          message.picture.attach(io: open(url), filename: message.picture_file_name, content_type: message.picture_content_type)
        when "video"
          message.video.attach(io: open(url), filename: message.video_file_name, content_type: message.video_content_type)
        when "audio"
          message.audio.attach(io: open(url), filename: message.audio_file_name, content_type: message.audio_content_type)
        end
      end
    end

  end
end
