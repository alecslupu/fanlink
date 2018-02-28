describe "People (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
  end

  before(:each) do
    logout
  end

  describe "#change_password" do
    it "should change the current users password" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      login_as(person)
      patch "/people/#{person.id}/change_password", params: { person: { current_password: current, new_password: new_password } }
      expect(response).to be_success
      expect(person.reload.valid_password?(new_password)).to be_truthy
    end
    it "should not change the current users password to one that is too short" do
      current = "secret"
      new_password = "short"
      person = create(:person, password: current)
      login_as(person)
      patch "/people/#{person.id}/change_password", params: { person: { current_password: current, new_password: new_password } }
      expect(response).to be_unprocessable
      expect(json["errors"].first).to include("too short")
    end
    it "should not change the current users password if wrong password given" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      login_as(person)
      patch "/people/#{person.id}/change_password", params: { person: { current_password: "wrongpassword", new_password: new_password } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("incorrect")
    end
    it "should not change the user password if not logged in" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      patch "/people/#{person.id}/change_password", params: { person: { current_password: current, new_password: new_password } }
      expect(response).to be_unauthorized
      expect(person.reload.valid_password?(current)).to be_truthy
    end
    it "should not change the password if wrong user id in url" do
      pers = create(:person)
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      login_as(person)
      patch "/people/#{pers.id}/change_password", params: { person: { current_password: current, new_password: new_password } }
      expect(response).to be_not_found
      expect(person.reload.valid_password?(current)).to be_truthy
    end
  end
  describe "#create" do
    it "should sign up new user with email, username, and password and send onboarding email" do
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
      expect(email_sent(template: "#{p.product.internal_name}-onboarding",
                        to_values: { email: p.email, name: p.name })
      ).to_not be_nil
    end
    it "should sign up new user with FB auth token and send onboarding email" do
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
      expect(email_sent(template: "#{p.product.internal_name}-onboarding",
                        to_values: { email: p.email, name: p.name })
      ).to_not be_nil
    end
    it "should sign up new user with FB auth token without email and not send onboarding email" do
      tok = "1234"
      username = "newuser#{Time.now.to_i}"
      product = create(:product)
      koala_result = { "id" => "12345", "name" => "John Smith" }
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
      expect {
        post "/people", params: { product: product.internal_name, facebook_auth_token: tok, person: { username: username } }
      }.to change { Person.count }.by(1)
      expect(response).to be_success
      p = Person.last
      expect(p.username).to eq(username)
      expect(json["person"]).to eq(person_private_json(p))
      expect(email_sent(template: "#{p.product.internal_name}-onboarding",
                        to_values: { name: p.name })
      ).to be_nil
    end
    it "should not sign up new user if there is a problem with FB" do
      tok = "1234"
      username = "newuser#{Time.now.to_i}"
      product = create(:product)
      expect(Person).to receive(:create_from_facebook).with(tok, username).and_return(nil)
      expect {
        post "/people", params: { product: product.internal_name, facebook_auth_token: tok, person: { username: username } }
      }.to change { Person.count }.by(0)
      expect(response.status).to eq(503)
      expect(json["errors"]).to include("problem contacting Facebook")
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
    it "should not get person if not logged in" do
      person = create(:person)
      get "/people/#{person.id}"
      expect(response).to be_unauthorized
    end
    it "should return 404 if bad id" do
      person = create(:person)
      login_as(person)
      get "/people/#{Person.last.id + 1}"
      expect(response).to be_not_found
    end
    it "should return 404 if from another product" do
      person = create(:person)
      login_as(person)
      other = create(:person, product: create(:product))
      get "/people/#{other.id}"
      expect(response).to be_not_found
    end
  end

  describe "#update" do
    it "should update a person" do
      person = create(:person)
      login_as(person)
      new_username = "thisbetterbeunique"
      new_email = "fooism@example.com"
      new_name = "Joe Foo"
      patch "/people/#{person.id}", params: { person: { email: new_email, name: new_name, username: new_username } }
      expect(response).to be_success
      per = person.reload
      expect(per.username).to eq(new_username)
      expect(per.email).to eq(new_email)
      expect(per.name).to eq(new_name)
    end
    it "should not update a different person" do
      person = create(:person)
      other = create(:person, product: person.product)
      original_username = other.username
      login_as(person)
      new_username = "thisbetterbeunique"
      patch "/people/#{other.id}", params: { person: { username: new_username } }
      expect(response).to be_not_found
      oth = other.reload
      expect(oth.username).to eq(original_username)
    end
  end

end
