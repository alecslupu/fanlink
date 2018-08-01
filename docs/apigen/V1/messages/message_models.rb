FanlinkApi::API.model :message_app_json do
  type :object do
    message :object do
      id :int32
      person_id :int32
      room_id :int32
      body :string
      hidden :bool
      created_time :datetime
      status :int32
      picture_url :string
      audio_url :string
      audio_size :string
      audio_content_type :string
      person :person_app_json
      mentions :mention_app_json
    end
  end
end

FanlinkApi::API.model :message_portal_json do
  type :object do
    message :object do
      id :int32
      person_id :int32
      room_id :int32
      body :string
      hidden :bool
      created_at :string
      updated_at :string
      status :int32
      picture_url :string
      audio_url :string
    end
  end
end
