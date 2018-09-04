FanlinkApi::API.model :room_membership_app_json do
  type :object do
    room_membership :object do
      id :int32
      room_id :int32
      person_id :int32
      created_at :string
      updated_at :string
      message_count :int32
    end
  end
end
