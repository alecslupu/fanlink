describe "People (v1)" do

  describe "#create" do
    it "should sign up new user with email, username and password" do
      username = "newuser#{Time.now.to_i}"
      email = "#{username}@example.com"
      password = "secret"
      product = create(:product)
      expect {
        post "/people", params: { product: product.internal_name, person: { username: username, email: email, password: password } }
      }.to change { Person.count }.by(1)
      expect(response).to be_success
      p = Person.last
      expect(p.email).to eq(email)
      expect(p.username).to eq(username)
      expect(json["person"]).to eq(person_private_json(p))
    end
    it "should sign up new user with FB auth token" do
      tok = "1234"
      username = "newuser#{Time.now.to_i}"
      product = create(:product)
      email = "johnsmith432143343@example.com"
      koala_result = { "id" => "12345", "name" => "John Smith", "email" => email }
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
      expect {
        post "/people", params: { product: product.internal_name, person: { username: username, facebook_auth_token: tok } }
      }.to change { Person.count }.by(1)
      expect(response).to be_success
      p = Person.last
      expect(p.email).to eq(email)
      expect(p.username).to eq(username)
      expect(json["person"]).to eq(person_private_json(p))
    end
  end
end
