FanlinkApi::API.model :event_json do
  type :object do
    event :object do
      id :int32
      product_id :int32
      name :string
      description :string
      starts_at :string
      ends_at :string
      ticket_url :string
      place_identifier :string
      created_at :string
      updated_at :string
      deleted :bool
    end
  end
end
