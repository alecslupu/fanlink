module RealTimeHelpers
  protected

    def client
      @fb ||=  Firebase::Client.new(Rails.application.secrets.firebase_url, Rails.application.secrets.firebase_key.to_json)
    end

    def versioned_message_counter_path(membership, version)
      "#{versioned_user_path(membership.person, version)}/message_counts/#{membership.room_id}"
    end

    def versioned_room_path(room, version)
      "#{room.product.internal_name}/v#{version}/rooms/#{room.id}"
    end

    def versioned_user_path(person, version)
      "#{person.product.internal_name}/v#{version}/users/#{person.id}"
    end

    def message_counter_path(membership)
      "#{user_path(membership.person)}/message_counts/#{membership.room_id}"
    end

    def room_path(room)
      "#{room.product.internal_name}/rooms/#{room.id}"
    end

    def user_path(person)
      "#{person.product.internal_name}/users/#{person.id}"
    end
end
