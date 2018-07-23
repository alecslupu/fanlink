FanlinkApi::API.model :room_json do
  type :object do
    room :object do
      id :int32
      product_id :int32
      created_by_id :int32
      status :int32
      public :bool
      created_at :string
      updated_at :string
      picture_file_name :string
      picture_content_type :string
      picture_file_size :int32
      picture_updated_at :string
      name :string
      description :string
    end
  end
end
