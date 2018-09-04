FanlinkApi::API.model :recommended_post_app_json do
  type :object do
    recommended_post :object do
      type :post_app_json
    end
  end
end
