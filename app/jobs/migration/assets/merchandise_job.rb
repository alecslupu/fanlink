module Migration
  module Assets
    class MerchandiseJob < ::Migration::Assets::ApplicationJob
      def perform(merchandise_id)
        require 'open-uri'
        merchandise = ::Merchandise.find(merchandise_id)
        url = paperclip_asset_url(merchandise, 'picture', merchandise.product)
        merchandise.picture.attach(io: open(url), filename: merchandise.picture_file_name, content_type: merchandise.picture_content_type)
      end
    end
  end
end
