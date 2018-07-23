FanlinkApi::API.model :level_json do
  type :object do
    level :object do
      id :int32
      product_id :int32
      internal_name :string
      points :int32
      created_at :string
      updated_at :string
      picture_file_name :string
      picture_content_type :string
      picture_file_size :int32
      picture_updated_at :string
      description :string
      name :string
    end
  end
end
