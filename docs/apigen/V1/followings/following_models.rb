FanlinkApi::API.model :following_app_json do
  type :object do
    following :object do
      id :int32
      follower :person_app_json
      following :person_app_json
    end
  end
end


FanlinkApi::API.model :following_portal_json do
  type :object do
    following :object do
      id :int32
      follower_id :int32
      following_id :int32
    end
  end
end
