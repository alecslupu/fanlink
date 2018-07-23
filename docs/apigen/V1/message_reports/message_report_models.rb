FanlinkApi::API.model :message_report_json do
  type :object do
    message_report :object do
      id :int32
      message_id :int32
      person_id :int32
      reason :string
      status :int32
      created_at :string
      updated_at :string
    end
  end
end
