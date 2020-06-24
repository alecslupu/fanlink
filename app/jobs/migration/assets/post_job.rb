module Migration
  module Assets
    class PostJob < ::Migration::Assets::ApplicationJob
      def perform(post_id, what)
        require 'open-uri'
        post = ::Post.find(post_id)

        url = paperclip_asset_url(post, what, post.product)
        case what
        when 'picture'
          post.picture.attach(io: open(url), filename: post.picture_file_name, content_type: post.picture_content_type)
        when 'video'
          post.video.attach(io: open(url), filename: post.video_file_name, content_type: post.video_content_type)
          post.video_transcoded = {}
          post.video_job_id = nil
          post.save!
          post.send(:start_transcoding)
        when 'audio'
          post.audio.attach(io: open(url), filename: post.audio_file_name, content_type: post.audio_content_type)
        end
      end
    end
  end
end
