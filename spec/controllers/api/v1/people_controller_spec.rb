# frozen_string_literal: true
require "spec_helper"


RSpec.describe Api::V1::PeopleController, type: :controller do
  describe "#change_password" do
    it "should change the current users password" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password, params: { id: person.id, person: { current_password: current, new_password: new_password } }
        expect(response).to be_successful
        expect(person.reload.valid_password?(new_password)).to be_truthy
      end
    end
    it "should not change the current users password to one that is too short" do
      current = "secret"
      new_password = "short"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password, params: { id: person.id, person: { current_password: current, new_password: new_password } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Password must be at least 6 characters in length.")
      end
    end
    it "should not change the current users password if wrong password given" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password, params: { id: person.id, person: { current_password: "wrongpassword", new_password: new_password } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("The password is incorrect")
      end
    end
    it "should not change the user password if not logged in" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        patch :change_password, params: { id: person.id, person: { current_password: current, new_password: new_password } }
        expect(response).to be_unauthorized
        expect(person.reload.valid_password?(current)).to be_truthy
      end
    end
    it "should not change the password if wrong user id in url" do
      pers = create(:person)
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password, params: { id: pers.id, person: { current_password: current, new_password: new_password } }
        expect(response).to be_not_found
        expect(person.reload.valid_password?(current)).to be_truthy
      end
    end
  end

  describe "#create" do
    it "should sign up new user with email, username, and password, profile fields and send onboarding email", :run_delayed_jobs do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect_any_instance_of(Person).to receive(:do_auto_follows)
        expect_any_instance_of(Person).to receive(:send_onboarding_email)
        username = "newuser#{Time.now.to_i}"
        email = "#{username}@example.com"
        post :create, params:
          { product: product.internal_name,
           person: { username: username, email: email, password: "secret", gender: "male",
                    birthdate: "2000-01-02", city: "Shambala", country_code: "us", }, }
        expect(response).to be_successful
        p = Person.last
        expect(p.email).to eq(email)
        expect(p.username).to eq(username)
        expect(p.gender).to eq("male")
        expect(p.birthdate).to eq(Date.parse("2000-01-02"))
        expect(p.city).to eq("Shambala")
        expect(p.country_code).to eq("US")
        # expect(json["person"]).to eq(person_private_json(p))
        expect(person_private_json(json["person"])).to be true
      end
    end

    it "should sign up new user with FB auth token and send onboarding email", :run_delayed_jobs do
      tok = "1234"
      username = "newuser#{Time.now.to_i}"
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        email = "johnsmith432143343@example.com"
        koala_result = { "id" => "12345", "name" => "John Smith", "email" => email }
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
        expect_any_instance_of(Person).to receive(:send_onboarding_email)

        expect {
          post :create, params: { product: product.internal_name, facebook_auth_token: tok, person: { username: username } }
        }.to change { Person.count }.by(1)
        expect(response).to be_successful
        p = Person.last
        expect(p.email).to eq(email)
        expect(p.username).to eq(username)
        # expect(json["person"]).to eq(person_private_json(p))
        expect(person_private_json(json["person"])).to be true
      end
    end
    it "should sign up new user with FB auth token without email and not send onboarding email" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        tok = "1234"
        username = "newuser#{Time.now.to_i}"
        product = create(:product)
        koala_result = { "id" => "12345", "name" => "John Smith" }
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
        expect_any_instance_of(Person).not_to receive(:send_onboarding_email)

        expect {
          post :create, params: { product: product.internal_name, facebook_auth_token: tok, person: { username: username } }
        }.to change { Person.count }.by(1)
        expect(response).to be_successful
        p = Person.last
        expect(p.username).to eq(username)
        # expect(json["person"]).to eq(person_private_json(p))
        expect(person_private_json(json["person"])).to be true
      end
    end

    it "should not sign up new user if there is a problem with FB" do
      tok = "1234"
      username = "newuser#{Time.now.to_i}"
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect(Person).to receive(:create_from_facebook).with(tok, username).and_return(nil)
        expect {
          post :create, params: { product: product.internal_name, facebook_auth_token: tok, person: { username: username } }
        }.to change { Person.count }.by(0)
        expect(response.status).to eq(503)
        expect(json["errors"]).to include("problem contacting Facebook")
      end
    end
    it "should not sign up new user with username already used" do
      username = "newuser#{Time.now.to_i}"
      person = create(:person, username: username)
      ActsAsTenant.with_tenant(person.product) do
        expect {
          post :create, params: { product: person.product.internal_name, person: { email: "nobodyimportant@example.com",
                                                                                 username: username, password: "anything", }, }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("The username has already been taken.")
      end
    end
    # it "should not sign up new user with email already used"
    it "should not sign up new user with email already used" do
      email = "alreadyused@example.com"
      person = create(:person, email: email)
      ActsAsTenant.with_tenant(person.product) do
        expect {
          post :create, params: { product: person.product.internal_name, person: { email: email,
                                                                                 username: "anything", password: "anything", }, }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("A user has already signed up with that email address.")
      end
    end
    it "should not sign up new user without an email" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect {
          post :create, params: { product: product.internal_name, person: { username: "anything", password: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Email is required.")
      end
    end
    it "should not sign up new user with an invalid email" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect {
          post :create, params: { product: product.internal_name, person: { email: "nogood", username: "anything", password: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Email is invalid.")
      end
    end
    it "should not sign up new user without a username" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect {
          post :create, params: { product: product.internal_name, person: { email: "anything#{Time.now.to_i}@example.com", password: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Username is required.")
      end
    end
    it "should not sign up new user with a username less than 5 characters" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect {
          post :create, params: { product: product.internal_name, person: { username: "abcd", email: "anything#{Time.now.to_i}@example.com", password: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Username must be 5 to 25 characters with no special characters or spaces")
      end
    end
    it "should not sign up new user with a username more than 25 characters" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect {
          post :create, params: { product: product.internal_name, person: { username: "a" * 26, email: "anything#{Time.now.to_i}@example.com", password: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Username must be 5 to 25 characters with no special characters or spaces")
      end
    end

    it "should not sign up new user with a username that contains special characters" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect {
          post :create, params: { product: product.internal_name, person: { username: "abcde$", email: "anything#{Time.now.to_i}@example.com", password: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Username must be 5 to 25 characters with no special characters or spaces")
      end
    end

    it "should not sign up new user with an invalid email" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect {
          post :create, params: { product: product.internal_name, person: { username: "abc", email: "anything", password: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Email is invalid.")
      end
    end

    it "should not sign up new user with FB auth token if account with FB id already exists" do
      tok = "1234"
      fbid = "12345"
      person = create(:person, facebookid: fbid)
      ActsAsTenant.with_tenant(person.product) do
        koala_result = { "id" => fbid, "name" => "John Smith" }
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
        expect {
          post :create, params: { product: person.product.internal_name, facebook_auth_token: tok, person: { username: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("A user has already signed up with that Facebook account.")
      end
    end
    it "should not sign up new user with FB auth token if account with email already exists" do
      tok = "1234"
      email = "taken#{Time.now.to_i}@example.com"
      person = create(:person, email: email)
      ActsAsTenant.with_tenant(person.product) do
        koala_result = { "id" => "12345", "name" => "John Smith", "email" => email }
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
        expect {
          post :create, params: { product: person.product.internal_name, facebook_auth_token: tok, person: { username: "anything" } }
        }.to change { Person.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("A user has already signed up with that email address.")
      end
    end

    it "should create a person with a picture attached if added" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect_any_instance_of(Person).to receive(:do_auto_follows)
        username = "newuser#{Time.now.to_i}"
        email = "#{username}@example.com"
        post :create, params:
          { product: product.internal_name,
            person: {
              username: username,
              email: email,
              password: "password",
              gender: "male",
              birthdate: "2019-01-02",
              city: "Las Vegas",
              country_code: "us",
              picture: fixture_file_upload("images/better.png", "image/png")
            }
          }
        expect(response).to be_successful
        expect(json["person"]["picture_url"]).to_not eq(nil)
        expect(Person.last.picture.exists?).to be_truthy
      end
    end
  end

  describe "#index" do
    it "should not get people if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index
        expect(response).to be_unauthorized
      end
    end
    it "should get all people with no filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person1 = build(:person, username: "pers1", email: "pers1@example.com")
        person2 = build(:person, username: "pers2", email: "pers2@example.com")
        person3 = build(:person, username: "pers3", email: "pers3@example.com")
        person4 = build(:person, username: "pers4", email: "pers4@example.com")
        person5 = build(:person, username: "pers5", email: "pers5@example.com")
        normal_person = create(:person, username: "normal", email: "normal@example.com")
        login_as(normal_person)

        allow(subject).to receive(:apply_filters).and_return [person, normal_person, person1, person2, person3, person4, person5]

        get :index
        expect(response).to be_successful
        expect(json["people"].count).to eq(7)
      end
    end
    it "should page 1 of all people with no filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        normal_person = create(:person, username: "normal", email: "normal@example.com")
        person4 = build(:person, username: "pers4", email: "pers4@example.com")
        person5 = build(:person, username: "pers5", email: "pers5@example.com")

        login_as(normal_person)

        allow(subject).to receive(:apply_filters).and_return [person4, person5]

        get :index, params: { page: 1, per_page: 2 }
        expect(response).to be_successful
        expect(json["people"].count).to eq(2)
      end
    end
    it "should page 2 of all people with no filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do

        normal_person = create(:person, username: "normal", email: "normal@example.com")
        # person1 =
        create(:person, username: "pers1", email: "pers1@example.com")
        person2 = create(:person, username: "pers2", email: "pers2@example.com")
        person3 = create(:person, username: "pers3", email: "pers3@example.com")
        create(:person, username: "pers4", email: "pers4@example.com")
        create(:person, username: "pers5", email: "pers5@example.com")

        login_as(normal_person)
        get :index, params: { page: 2, per_page: 2 }
        expect(response).to be_successful
        expected = [person3.id, person2.id]
        expect(json["people"].count).to eq(expected.count)
        listed_ids = json["people"].map { |p| p["id"].to_i }
        expect(listed_ids).to eq(expected)
      end
    end
    it "should all people using default per page" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person1 = create(:person, username: "pers1", email: "pers1@example.com")
        person2 = create(:person, username: "pers2", email: "pers2@example.com")
        person3 = create(:person, username: "pers3", email: "pers3@example.com")
        person4 = create(:person, username: "pers4", email: "pers4@example.com")
        person5 = create(:person, username: "pers5", email: "pers5@example.com")
        normal_person = create(:person, username: "normal", email: "normal@example.com")

        login_as(person)

        allow(subject).to receive(:apply_filters).and_return [normal_person, person1, person2, person3, person4, person5]

        get :index, params: { page: 1 }
        expect(response).to be_successful
        # expected = [normal_person.id, person5.id, person4.id, person3.id, person2.id, person1.id, person.id]
        expect(json["people"].count).to eq(6)
        # listed_ids = json["people"].map { |p| p["id"].to_i }
        # expect(listed_ids).to eq(expected)
      end
    end
    it "should get no people using default per page for page 2" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: { page: 2 }
        expect(response).to be_successful
        expect(json["people"].count).to eq(0)
      end
    end
    it "should get no people with username filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: { username_filter: "notthere" }
        expect(response).to be_successful
        expect(json["people"].count).to eq(0)
      end
    end
    it "should get people with username filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person1 = build(:person, username: "pers1", email: "pers1@example.com")
        person2 = build(:person, username: "pers2", email: "pers2@example.com")
        person3 = build(:person, username: "pers3", email: "pers3@example.com")
        person4 = build(:person, username: "pers4", email: "pers4@example.com")
        person5 = build(:person, username: "pers5", email: "pers5@example.com")
        login_as(person)

        allow(subject).to receive(:apply_filters).and_return [person1, person2, person3, person4, person5]

        get :index, params: { username_filter: "ers" }
        expect(response).to be_successful
        expect(json["people"].count).to eq(5)
        # listed_ids = json["people"].map { |p| p["id"].to_i }
        # expect(listed_ids.sort).to eq([person1.id, person2.id, person3.id, person4.id, person5.id].sort)
      end
    end
    # it "should not return the current user with the username filter"
    it "should get a person with username filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person1 = create(:person, username: "pers1", email: "pers1@example.com")
        login_as(person)
        get :index, params: { username_filter: "ers1" }
        expect(response).to be_successful
        expect(json["people"].count).to eq(1)
        listed_ids = json["people"].map { |p| p["id"].to_i }
        expect(listed_ids).to eq([person1.id])
      end
    end
    it "should get no people with email filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: { email_filter: "notthere" }
        expect(response).to be_successful
        expect(json["people"].count).to eq(0)
      end
    end
    it "should get people with email filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person1 = build(:person, username: "pers1", email: "pers1@example.com")
        person2 = build(:person, username: "pers2", email: "pers2@example.com")
        person3 = build(:person, username: "pers3", email: "pers3@example.com")
        person4 = build(:person, username: "pers4", email: "pers4@example.com")
        person5 = build(:person, username: "pers5", email: "pers5@example.com")
        login_as(person)

        allow(subject).to receive(:apply_filters).and_return [person1, person2, person3, person4, person5]

        get :index, params: { email_filter: "ers" }
        expect(response).to be_successful
        expect(json["people"].count).to eq(5)
      end
    end
    it "should get a person with email filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person1 = create(:person, username: "pers1", email: "pers1@example.com")
        login_as(person)
        get :index, params: { email_filter: "ers1" }
        expect(response).to be_successful
        expect(json["people"].count).to eq(1)
        listed_ids = json["people"].map { |p| p["id"].to_i }
        expect(listed_ids).to eq([person1.id])
      end
    end
    it "should people with username and email filter" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person1 = build(:person, username: "pers1", email: "pers1@example.com")
        person2 = build(:person, username: "pers2", email: "pers2@example.com")
        person3 = build(:person, username: "pers3", email: "pers3@example.com")
        person4 = build(:person, username: "pers4", email: "pers4@example.com")
        person5 = build(:person, username: "pers5", email: "pers5@example.com")

        login_as(person)
        allow(subject).to receive(:apply_filters).and_return [person1, person2, person3, person4, person5]

        get :index, params: { email_filter: "example.com", username_filter: "pers" }
        expect(response).to be_successful
        expect(json["people"].count).to eq(5)
        # listed_ids = json["people"].map { |p| p["id"].to_i }
        # expect(listed_ids.sort).to eq([person1.id, person2.id, person3.id, person4.id, person5.id].sort)
      end
    end
    it "should people with username and email filter and paginated" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        person4 = create(:person, username: "pers4", email: "pers4@example.com")
        person5 = create(:person, username: "pers5", email: "pers5@example.com")
        login_as(person)

        allow(subject).to receive(:apply_filters).and_return [person4, person5]

        get :index, params: { email_filter: "example.com", username_filter: "pers", page: 1, per_page: 2 }
        expect(response).to be_successful
        expect(json["people"].count).to eq(2)
      end
    end

    it "should return the people objects with their attached picture" do
      person = create(:person, picture: fixture_file_upload("images/better.png", "image/png"))
      ActsAsTenant.with_tenant(person.product) do

        login_as(person)

        allow(subject).to receive(:apply_filters).and_return build_list(:person,3, picture: fixture_file_upload("images/better.png", "image/png"))

        get :index

        expect(response).to be_successful
        expect(json["people"].count).to eq(3)
        json["people"].each do |person|
          expect(person["picture_url"]).to_not eq(nil)
        end
      end
    end
  end

  describe "#show" do
    it "should get a single person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :show, params: { id: person.id }
        expect(response).to be_successful
        # expect(json["person"]).to eq(person_json(person))
        expect(person_json(json["person"])).to be true
      end
    end
    it "should not get person if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :show, params: { id: person.id }
        expect(response).to be_unauthorized
      end
    end
    it "should return 404 if bad id" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :show, params: { id: Person.last.id + 1 }
        expect(response).to be_not_found
      end
    end
    it "should return 404 if from another product" do
      other = create(:person, product: create(:product))
      person = create(:person, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :show, params: { id: other.id }
        expect(response).to be_not_found
      end
    end

    it "should return the people object with their attached picture" do
      person = create(:person, picture: fixture_file_upload("images/better.png", "image/png"))
      ActsAsTenant.with_tenant(person.product) do
        create_list(:person,3, picture: fixture_file_upload("images/better.png", "image/png"))

        login_as(person)
        get :show ,params: { id: person.id }

        expect(response).to be_successful
        expect(json["person"]["picture_url"]).to_not eq(nil)
      end
    end
  end

  describe "#update" do
    it "should update a person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        new_username = "thisbetterbeunique"
        new_email = "fooism@example.com"
        new_name = "Joe Foo"
        patch :update, params: { id: person.id, person: { email: new_email, name: new_name, username: new_username,
                                                        gender: "female", birthdate: "1999-03-03", city: "FooismTown", country_code: "fr", }, }
        expect(response).to be_successful
        per = person.reload
        expect(per.username).to eq(new_username)
        expect(per.email).to eq(new_email)
        expect(per.name).to eq(new_name)
        expect(per.gender).to eq("female")
        expect(per.birthdate).to eq(Date.parse("1999-03-03"))
        expect(per.city).to eq("FooismTown")
        expect(per.country_code).to eq("FR")
      end
    end
    it "should not update a different person by normal person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        other = create(:person)
        original_username = other.username
        login_as(person)
        new_username = "thisbetterbeunique"
        patch :update, params: { id: other.id, person: { username: new_username } }
        expect(response).to be_not_found
        oth = other.reload
        expect(oth.username).to eq(original_username)
      end
    end
    it "should update recommended by admin" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        rec_person = create(:person)
        expect(rec_person.recommended).to be_falsey
        login_as(person)
        patch :update, params: { id: rec_person.id, person: { recommended: true } }
        expect(response).to be_successful
        expect(rec_person.reload.recommended).to be_truthy
      end
    end
    it "should update recommended by product account" do
      person = create(:person, product_account: true)
      ActsAsTenant.with_tenant(person.product) do
        rec_person = create(:person)
        expect(rec_person.recommended).to be_falsey
        login_as(person)
        patch :update, params: { id: rec_person.id, person: { recommended: true } }
        expect(response).to be_successful
        expect(rec_person.reload.recommended).to be_truthy
      end
    end

    it "updates a person's picture" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        put :update, params: {
          id: person.id,
          person: {
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to be_successful
        expect(Person.last.picture.exists?).to be_truthy
        expect(json['person']['picture_url']).to include('better.png')
      end
    end
  end
end
