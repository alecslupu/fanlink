FanlinkApi::API.model :merchandise_app_json do
  type :object do
    merchandise :object do
      id :int32
      product_id :int32
      price :string
      purchase_url :string
      picture_url :string
      available :bool
      name :string
      description :string
      priority :int32
      deleted :bool
    end
  end
end

FanlinkApi::API.model :merchandise_portal_json do
  type :object do
    merchandise :object do
      id :int32
      product_id :int32
      price :string
      purchase_url :string
      picture_file_name :string
      picture_content_type :string
      picture_file_size :int32
      picture_updated_at :string
      created_at :string
      updated_at :string
      available :bool
      name :string
      description :string
      priority :int32
      deleted :bool
    end
  end
end
