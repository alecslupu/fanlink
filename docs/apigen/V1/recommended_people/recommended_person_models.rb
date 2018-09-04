FanlinkApi::API.model :recommended_person_app_json do
  type :object do
    recommended_person :object do
      type :person_app_json
    end
  end
end
