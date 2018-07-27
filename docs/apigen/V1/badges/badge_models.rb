FanlinkApi::API.model :badge_app_json do
  type :object do
    badge :object do
      id :int32
      name :string
      internal_name :string
      description :string
      picture_url :string
      action_requirement :int32
      point_value :int32
    end
  end
end

FanlinkApi::API.model :badge_portal_json do
  type :object do
    badge :object do
      id :int32
      name :string
      internal_name :string
      description :string
      picture_url :string
      action_requirement :int32
      point_value :int32
    end
  end
end
