FanlinkApi::API.model :password_reset_json do
  type :object do
    password_reset :object do
      type :string
    end
  end
end
