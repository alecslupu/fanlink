module Migration
  module Assets
    class BadgeJob < ::Migration::Assets::ApplicationJob
      def perform(badge_id)
        require 'open-uri'
        badge = ::Badge.find(badge_id)
        url = paperclip_asset_url(badge, 'picture', badge.product)
        badge.picture.attach(io: open(url), filename: badge.picture_file_name, content_type: badge.picture_content_type)
      end
    end
  end
end
