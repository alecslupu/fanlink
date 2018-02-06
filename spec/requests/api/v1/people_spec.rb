describe "People (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should sign up new user with email, username, and password" do
      expect_any_instance_of(Person).to receive(:do_auto_follows)
      username = "newuser#{Time.now.to_i}"
      email = "#{username}@example.com"
      post "/people", params:
          { product: @product.internal_name,
            person: { username: username, email: email, password: "secret" } }
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
        post "/people", params: { product: product.internal_name, facebook_auth_token: tok, person: { username: username } }
      }.to change { Person.count }.by(1)
      expect(response).to be_success
      p = Person.last
      expect(p.email).to eq(email)
      expect(p.username).to eq(username)
      expect(json["person"]).to eq(person_private_json(p))
    end
    it "should not sign up new user with username already used" do
      username = "newuser#{Time.now.to_i}"
      p = create(:person, username: username)
      expect {
        post "/people", params: { product: p.product.internal_name, person: { email: "nobodyimportant@example.com",
                                                                            username: username, password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("A user has already signed up with that username.")
    end
    it "should not sign up new user with email already used" do
      email = "alreadyused@example.com"
      p = create(:person, email: email)
      expect {
        post "/people", params: { product: p.product.internal_name, person: { email: email,
                                                                            username: "anything", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("A user has already signed up with that email address.")
    end
    it "should not sign up new user with email already used" do
      email = "alreadyused@example.com"
      p = create(:person, email: email)
      expect {
        post "/people", params: { product: p.product.internal_name, person: { email: email,
                                                                              username: "anything", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("A user has already signed up with that email address.")
    end
    it "should not sign up new user without an email" do
      expect {
        post "/people", params: { product: @prod_name, person: { username: "anything", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Email is required.")
    end
    it "should not sign up new user with an invalid email" do
      expect {
        post "/people", params: { product: @prod_name, person: { email: "nogood", username: "anything", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Email is invalid.")
    end
    it "should not sign up new user without a username" do
      expect {
        post "/people", params: { product: @prod_name, person: { email: "anything#{Time.now.to_i}@example.com", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Username is required.")
    end
    it "should not sign up new user with a username less than 3 characters" do
      expect {
        post "/people", params: { product: @prod_name, person: { username: "ab", email: "anything#{Time.now.to_i}@example.com", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Username must be between 3 and 26 characters")
    end
    it "should not sign up new user with a username more than 26 characters" do
      expect {
        post "/people", params: { product: @prod_name, person: { username: "a" * 27, email: "anything#{Time.now.to_i}@example.com", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Username must be between 3 and 26 characters")
    end
    it "should not sign up new user with an invalid email" do
      expect {
        post "/people", params: { product: @prod_name, person: { username: "abc", email: "anything", password: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Email is invalid.")
    end
    it "should not sign up new user with FB auth token if account with FB id already exists" do
      tok = "1234"
      fbid = "12345"
      fbperson = create(:person, facebookid: fbid, product: Product.first)
      koala_result = { "id" => fbid, "name" => "John Smith" }
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
      expect {
        post "/people", params: { product: Product.first.internal_name, facebook_auth_token: tok, person: { username: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("A user has already signed up with that Facebook account.")
    end
    it "should not sign up new user with FB auth token if account with email already exists" do
      tok = "1234"
      email = "taken#{Time.now.to_i}@example.com"
      fbperson = create(:person, email: email, product: Product.first)
      koala_result = { "id" => "12345", "name" => "John Smith", "email" => email }
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
      expect {
        post "/people", params: { product: Product.first.internal_name, facebook_auth_token: tok, person: { username: "anything" } }
      }.to change { Person.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("A user has already signed up with that email address.")
    end

  end

  describe "#show" do
    it "should get a single person" do
      person = create(:person)
      login_as(person)
      get "/people/#{person.id}"
      expect(response).to be_success
      expect(json["person"]).to eq(person_json(person))
    end
  end
end
