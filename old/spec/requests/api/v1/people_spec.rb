describe "People (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @prod_name = @product.internal_name
    @person = create(:person, product: @product)
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
      expect(json["errors"]).to include("Password must be at least 6 characters in length.")
    end
    it "should not change the current users password if wrong password given" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      login_as(person)
      patch "/people/#{person.id}/change_password", params: { person: { current_password: "wrongpassword", new_password: new_password } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("The password is incorrect")
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
    it "should sign up new user with email, username, and password, profile fields and send onboarding email" do
      expect_any_instance_of(Person).to receive(:do_auto_follows)
      username = "newuser#{Time.now.to_i}"
      email = "#{username}@example.com"
      post "/people", params:
          { product: @product.internal_name,
            person: { username: username, email: email, password: "secret", gender: "male",
                      birthdate: "2000-01-02", city: "Shambala", country_code: "us" } }
      expect(response).to be_success
      p = Person.last
      expect(p.email).to eq(email)
      expect(p.username).to eq(username)
      expect(p.gender).to eq("male")
      expect(p.birthdate).to eq(Date.parse("2000-01-02"))
      expect(p.city).to eq("Shambala")
      expect(p.country_code).to eq("US")
      # expect(json["person"]).to eq(person_private_json(p))
      expect(person_private_json(json["person"])).to be true
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
      # expect(json["person"]).to eq(person_private_json(p))
      expect(person_private_json(json["person"])).to be true
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
      # expect(json["person"]).to eq(person_private_json(p))
      expect(person_private_json(json["person"])).to be true
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

  describe "#index" do
    let!(:product) { create(:product) }
    let!(:person) { create(:person, product: product, username: "phil", email: "phil@example.com", role: :admin) }
    let!(:normal_person) { create(:person, product: product, username: "normal", email: "normal@example.com") }
    let!(:person1) { create(:person, product: product, username: "pers1", email: "pers1@example.com") }
    let!(:person2) { create(:person, product: product, username: "pers2", email: "pers2@example.com") }
    let!(:person3) { create(:person, product: product, username: "pers3", email: "pers3@example.com") }
    let!(:person4) { create(:person, product: product, username: "pers4", email: "pers4@example.com") }
    let!(:person5) { create(:person, product: product, username: "pers5", email: "pers5@example.com") }
    let!(:person_other) { create(:person, product: create(:product), username: "person_other", email: "person_other@example.com") }
    it "should not get people if not logged in" do
      get "/people"
      expect(response).to be_unauthorized
    end
    it "should get all people with no filter" do
      login_as(normal_person)
      get "/people"
      expect(response).to be_success
      expected = [person.id, person1.id, person2.id, person3.id, person4.id, person5.id, normal_person.id]
      expect(json["people"].count).to eq(expected.count)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids.sort).to eq(expected.sort)
    end
    it "should page 1 of all people with no filter" do
      login_as(normal_person)
      get "/people", params: { page: 1, per_page: 2 }
      expect(response).to be_success
      expected = [person5.id, person4.id]
      expect(json["people"].count).to eq(expected.count)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids).to eq(expected)
    end
    it "should page 2 of all people with no filter" do
      login_as(normal_person)
      get "/people", params: { page: 2, per_page: 2 }
      expect(response).to be_success
      expected = [person3.id, person2.id]
      expect(json["people"].count).to eq(expected.count)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids).to eq(expected)
    end
    it "should all people using default per page" do
      login_as(normal_person)
      get "/people", params: { page: 1 }
      expect(response).to be_success
      expected = [person5.id, person4.id, person3.id, person2.id, person1.id, normal_person.id, person.id]
      expect(json["people"].count).to eq(expected.count)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids).to eq(expected)
    end
    it "should get no people using default per page for page 2" do
      login_as(normal_person)
      get "/people", params: { page: 2 }
      expect(response).to be_success
      expect(json["people"].count).to eq(0)
    end
    it "should get no people with username filter" do
      login_as(person)
      get "/people", params: { username_filter: "notthere" }
      expect(response).to be_success
      expect(json["people"].count).to eq(0)
    end
    it "should get people with username filter" do
      login_as(person)
      get "/people", params: { username_filter: "ers" }
      expect(response).to be_success
      expect(json["people"].count).to eq(5)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids.sort).to eq([person1.id, person2.id, person3.id, person4.id, person5.id].sort)
    end
    # it "should not return the current user with the username filter" do
    #   login_as(person1)
    #   get "/people", params: { username_filter: "ers" }
    #   expect(response).to be_success
    #   expect(json["people"].count).to eq(4)
    #   listed_ids = json["people"].map { |p| p["id"].to_i }
    #   expect(listed_ids.sort).to eq([person2.id, person3.id, person4.id, person5.id].sort)
    # end
    it "should get a person with username filter" do
      login_as(person)
      get "/people", params: { username_filter: "ers1" }
      expect(response).to be_success
      expect(json["people"].count).to eq(1)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids).to eq([person1.id])
    end
    it "should get no people with email filter" do
      login_as(person)
      get "/people", params: { email_filter: "notthere" }
      expect(response).to be_success
      expect(json["people"].count).to eq(0)
    end
    it "should get people with email filter" do
      login_as(person)
      get "/people", params: { email_filter: "ers" }
      expect(response).to be_success
      expect(json["people"].count).to eq(5)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids.sort).to eq([person1.id, person2.id, person3.id, person4.id, person5.id].sort)
    end
    it "should get a person with email filter" do
      login_as(person)
      get "/people", params: { email_filter: "ers1" }
      expect(response).to be_success
      expect(json["people"].count).to eq(1)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids).to eq([person1.id])
    end
    it "should people with username and email filter" do
      login_as(person)
      get "/people", params: { email_filter: "example.com", username_filter: "pers" }
      expect(response).to be_success
      expect(json["people"].count).to eq(5)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids.sort).to eq([person1.id, person2.id, person3.id, person4.id, person5.id].sort)
    end
    it "should people with username and email filter and paginated" do
      login_as(person)
      get "/people", params: { email_filter: "example.com", username_filter: "pers", page: 1, per_page: 2 }
      expect(response).to be_success
      expect(json["people"].count).to eq(2)
      listed_ids = json["people"].map { |p| p["id"].to_i }
      expect(listed_ids.sort).to eq([person5.id, person4.id].sort)
    end
  end

  describe "#show" do
    it "should get a single person" do
      person = create(:person)
      login_as(person)
      get "/people/#{person.id}"
      expect(response).to be_success
      # expect(json["person"]).to eq(person_json(person))
      expect(person_json(json["person"])).to be true
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
      patch "/people/#{person.id}", params: { person: { email: new_email, name: new_name, username: new_username,
                                        gender: "female", birthdate: "1999-03-03", city: "FooismTown", country_code: "fr" } }
      expect(response).to be_success
      per = person.reload
      expect(per.username).to eq(new_username)
      expect(per.email).to eq(new_email)
      expect(per.name).to eq(new_name)
      expect(per.gender).to eq("female")
      expect(per.birthdate).to eq(Date.parse("1999-03-03"))
      expect(per.city).to eq("FooismTown")
      expect(per.country_code).to eq("FR")
    end
    it "should not update a different person by normal person" do
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
    it "should update recommended by admin" do
      person = create(:person, product: @product, role: :admin)
      rec_person = create(:person, product: @product)
      expect(rec_person.recommended).to be_falsey
      login_as(person)
      patch "/people/#{rec_person.id}", params: { person: { recommended: true } }
      expect(response).to be_success
      expect(rec_person.reload.recommended).to be_truthy
    end
    it "should update recommended by product account" do
      person = create(:person, product: @product, product_account: true)
      rec_person = create(:person, product: @product)
      expect(rec_person.recommended).to be_falsey
      login_as(person)
      patch "/people/#{rec_person.id}", params: { person: { recommended: true } }
      expect(response).to be_success
      expect(rec_person.reload.recommended).to be_truthy
    end
  end

end
