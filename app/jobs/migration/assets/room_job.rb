module Migration
  module Assets
    class RoomJob < ::Migration::Assets::ApplicationJob
      def perform(room_id)
        require 'open-uri'
        room = ::Room.find(room_id)
        url = paperclip_asset_url(room, 'picture', room.product)
        room.picture.attach(io: open(url), filename: room.picture_file_name, content_type: room.picture_content_type)
      end
    end
  end
end
