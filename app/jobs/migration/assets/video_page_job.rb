module Migration
  module Assets
    class VideoPageJob < ::Migration::Assets::ApplicationJob
      def perform(post_id)
        require 'open-uri'
        video = ::VideoPage.find(post_id)

        url = paperclip_asset_url(video, 'video', video.product)
        video.video.attach(io: open(url), filename: video.video_file_name, content_type: content_type(video))
        video.save!
      end

      private

      def content_type(video)
        video.video.attached? ? video.video.blob.content_type : nil
      end
    end
  end
end
