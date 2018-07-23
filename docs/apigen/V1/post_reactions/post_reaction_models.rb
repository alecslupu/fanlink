FanlinkApi::API.model :post_reaction_json do
  type :object do
    post_reaction :object do
      id :int32
      post_id :int32
      person_id :int32
      reaction :string
    end
  end
end
