FanlinkApi::API.model :following_json do
  type :object do
    following :object do
      id :int32
      follower_id :int32
      followed_id :int32
      created_at :string
      updated_at :string
    end
  end
end
