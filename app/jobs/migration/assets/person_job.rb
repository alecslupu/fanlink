module Migration
  module Assets
    class PersonJob < ::Migration::Assets::ApplicationJob
      def perform(person_id)
        require 'open-uri'
        person = ::Person.find(person_id)
        url = paperclip_asset_url(person, 'picture', person.product)
        person.picture.attach(io: open(url), filename: person.picture_file_name, content_type: person.picture_content_type)
      end
    end
  end
end
