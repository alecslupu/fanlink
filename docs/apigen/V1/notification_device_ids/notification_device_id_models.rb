FanlinkApi::API.model :notification_device_id_app_json do
  type :object do
    notification_device_id :object do
      id :int32
      person_id :int32
      device_identifier :string
      created_at :datetime
      updated_at :datetime
    end
  end
end

FanlinkApi::API.model :notification_device_id_portal_json do
  type :object do
    notification_device_id :object do
      id :int32
      person_id :int32
      device_identifier :string
      created_at :datetime
      updated_at :datetime
    end
  end
end
