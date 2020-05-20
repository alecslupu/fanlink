# frozen_string_literal: true
require 'swagger_helper'


RSpec.describe "Api::V4::PeopleController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/people" do
    get "" do
      security [Bearer: []]
      tags "People"

      produces "application/vnd.api.v4+json"
      consumes "application/vnd.api.v4+json"

      parameter name: :product, in: :query,  type: :string
      parameter name: :product_account_filter, in: :query, required: false, type: :string
      parameter name: :email_filer, in: :query, required: false, type: :string
      parameter name: :username_filter, in: :query, required: false, type: :string
      let(:product) { create(:product).internal_name }
      let(:Authorization) { "" }

      #android-old
      context "email_filer" do
        response "200", "HTTP/1.1 200 Ok" do
          schema "$ref": "#/definitions/PeopleArray"
          let(:people) { create_list(:person, 20) }
          let(:person) { FactoryBot.create(:person).reload}
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
          let(:email_filer) { "email@" }
          run_test!
        end
        response "401", "" do
          run_test!
        end

        response 500, "Internal server error" do
          document_response_without_test!
        end
      end

      #android-old
      context "username_filter" do

        response "200", "HTTP/1.1 200 Ok" do
          schema "$ref": "#/definitions/PeopleArray"
          let(:people) { create_list(:person, 20) }
          let(:person) { FactoryBot.create(:person).reload}
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
          let(:username_filter) { "User" }
          run_test!
        end
        response "401", "" do
          run_test!
        end

        response 500, "Internal server error" do
          document_response_without_test!
        end
      end

      #kotlin
      context "product_account_filter" do

        response "200", "HTTP/1.1 200 Ok" do
          schema "$ref": "#/definitions/PeopleArray"
          let(:people) { create_list(:person, 20) }
          let(:person) { FactoryBot.create(:person).reload}
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
          let(:product_account_filter) { true }
          run_test!
        end
        response "401", "" do
          run_test!
        end

        response 500, "Internal server error" do
          document_response_without_test!
        end
      end
    end

    post "" do
      tags "People" #kotlin

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :product, in: :query, type: :string, required: true
      parameter name: :"person[email]", in: :formData, type: :string, required: false
      parameter name: :"person[username]", in: :formData, type: :string, required: true
      parameter name: :"person[password]", in: :formData, type: :string, required: false
      parameter name: :"person[picture]", in: :formData,  type: :file
      parameter name: :facebook_auth_token, in: :formData, type: :string, required: false
      parameter name: :referrer, in: :formData,  type: :string, required: false

      let(:product) { }
      let("person[picture]") {  }
      let("person[email]") { Faker::Internet.email }
      let("person[username]") { "SomeValidUsername" }
      let("person[password]") { Faker::Internet.password }

      response "200", "HTTP/1.1 200 Ok" do
        schema "$ref": "#/definitions/PersonObject"
        let!(:product) { create(:product).internal_name }
        let!(:static_system_email) { create(:static_system_email, name: "onboarding") }

        run_test!
      end

      response "422", "" do
        let("person[picture]") {  }
        run_test!
      end

      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end

  path "/people/{id}" do
    patch "" do
      security [Bearer: []]
      tags 'People'

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"


      parameter name: :id, in: :path, type: :string
      let(:person) { create(:person) }
      let(:other_person) { create(:person)}
      let(:id) { person.id }
      let(:Authorization) { "" }

      parameter name: :"person[email]", in: :formData, type: :string
      parameter name: :"person[biography]", in: :formData, type: :string
      parameter name: :"person[name]", in: :formData, type: :string
      parameter name: :"person[picture]", in: :formData,  type: :file
      parameter name: :"person[gender]", in: :formData, type: :string
      parameter name: :"person[birthdate]", in: :formData, type: :string
      parameter name: :"person[city]", in: :formData, type: :string
      parameter name: :"person[country_code]", in: :formData, type: :string


      let("person[city]") { Faker::Address.city }
      let("person[country_code]") { Faker::Address.country_code }
      let("person[birthdate]") { Faker::Date.birthday(min_age: 18, max_age: 65) }
      let("person[gender]") { Faker::Gender.binary_type.downcase }
      let("person[email]") { Faker::Internet.email }
      let("person[picture]") {  }
      let("person[biography]") { Faker::Lorem.paragraph }
      let("person[name]") { Faker::Name.name }

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/PersonObject"
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }

        let(:id) { other_person.id }
        run_test!
      end
      response "422", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let("person[email]") { "" }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end

    get "" do
      security [Bearer: []]
      tags "People" # old android

      produces "application/vnd.api.v4+json"

      parameter name: :id, in: :path, type: :string

      let(:person) { create(:person) }
      let(:other_person) { create(:person)}
      let(:id) { other_person.id }
      let(:Authorization) { "" }

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }

        schema "$ref": "#/definitions/PersonObject"
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:id) { 0 }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end

  path "/people/{id}/change_password" do
    patch "" do
      security [Bearer: []]
      tags "People" # old android

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :id, in: :path, type: :string
      parameter name: :"person[current_password]", in: :formData, type: :string, required: true
      parameter name: :"person[new_password]", in: :formData, type: :string, required: true

      let(:current_password) { 'changeme24' }
      let(:person) { create(:person, password: current_password) }
      let(:id) { person.id }
      let("person[current_password]") { current_password }
      let(:Authorization) { "" }
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let("person[new_password]") { "24changedid" }

        run_test!
      end
      response "401", "" do
        let("person[new_password]") { "24changedid" }
        run_test!
      end
      response "422", "" do
        let("person[new_password]") { "short" }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, "Internal server error" do
        let("person[new_password]") { "short" }
        document_response_without_test!
      end
    end
  end

  path "/people/{user_id}/interests" do
    get "" do
      security [Bearer: []]
      tags "Interests"

      parameter name: :user_id, in: :path, type: :string

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:person) { create(:person) }
      let(:Authorization) { "" }
      let(:user_id) { 0 }

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:user_id) { person.id }
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }

        let(:user_id) { Time.zone.now.to_i }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
