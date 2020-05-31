module Migration
  module Assets
    class LevelJob < ::Migration::Assets::ApplicationJob
      queue_as :migration

      def perform(level_id)
        require 'open-uri'
        level = ::Level.find(level_id)
        url = paperclip_asset_url(level, "picture", level.product)
        level.picture.attach(io: open(url), filename: level.picture_file_name, content_type: level.picture_content_type)
      end
    end
  end
end
