FanlinkApi::API.model :recommended_person_json do
  type :object do
    recommended_person :object do
      type :person_json
    end
  end
end
