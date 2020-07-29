module Migration
  module Assets
    class ImagePageJob < ::Migration::Assets::ApplicationJob
      def perform(file_id)
        require 'open-uri'
        file = ::ImagePage.find(file_id)
        url = paperclip_asset_url(file, 'image', file.product)
        file.image.attach(io: open(url), filename: file.image_file_name, content_type: content_type(file))
      end

      private

      def content_type(file)
        file.image.attached? ? file.image.blob.content_type : nil
      end
    end
  end
end
