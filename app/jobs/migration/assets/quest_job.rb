module Migration
  module Assets
    class QuestJob < ::Migration::Assets::ApplicationJob
      def perform(quest_id)
        require 'open-uri'
        quest = ::Quest.find(quest_id)
        url = paperclip_asset_url(quest, 'picture', quest.product)
        quest.picture.attach(io: open(url), filename: quest.picture_file_name, content_type: quest.picture_content_type)
      end
    end
  end
end
