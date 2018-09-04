FanlinkApi::API.model :post_comment_report_app_json do
  type :object do
    post_comment_report :object do
      id :int32
      post_comment_id :int32
      person_id :int32
      reason :string
      status :int32
      created_at :string
      updated_at :string
    end
  end
end
