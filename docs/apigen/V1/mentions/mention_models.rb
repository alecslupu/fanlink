FanlinkApi::API.model :mention_app_json do
  type :object do
    mention :object do
      id :int32
      person_id :int32
      location :int32
      length :int32
    end
  end
end

FanlinkApi::API.model :mention_portal_json do
  type :object do
    mention :object do
      id :int32
      person_id :int32
      location :int32
      length :int32
    end
  end
end
