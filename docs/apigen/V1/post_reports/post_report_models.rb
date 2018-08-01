FanlinkApi::API.model :post_report_app_json do
  type :object do
    post_report :object do
      id :int32
      post_id :int32
      person_id :int32
      reason :string
      status :int32
      created_at :datetime
      updated_at :datetime
    end
  end
end

FanlinkApi::API.model :post_report_portal_json do
  type :object do
    post_report :object do
      id :int32
      post_id :int32
      person_id :int32
      reason :string
      status :int32
      created_at :datetime
      updated_at :datetime
    end
  end
end
