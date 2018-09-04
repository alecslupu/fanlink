FanlinkApi::API.model :post_comment_app_json do
  type :object do
    post_comment :object do
      id :int32
      post_id :int32
      person_id :int32
      body :string
      hidden :bool
      created_at :string
      updated_at :string
    end
  end
end
