FanlinkApi::API.model :relationship_json do
  type :object do
    relationship :object do
      id :int32
      requested_by_id :int32
      requested_to_id :int32
      status :int32
      created_at :string
      updated_at :string
    end
  end
end
