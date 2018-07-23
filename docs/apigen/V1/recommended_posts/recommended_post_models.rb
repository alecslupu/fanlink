FanlinkApi::API.model :recommended_post_json do
  type :object do
    recommended_post :object do
      type :post_json
    end
  end
end
