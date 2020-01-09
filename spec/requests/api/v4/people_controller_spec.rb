require 'swagger_helper'

RSpec.describe "Api::V4::PeopleController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/people" do
    get "" do
      security [Bearer: []]
      tags "user"

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
        response "200", "" do
          schema "$ref": "#/definitions/session_jwt"
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

        response "200", "" do
          schema "$ref": "#/definitions/session_jwt"
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

        response "200", "" do
          schema "$ref": "#/definitions/session_jwt"
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
      tags "user" #kotlin

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :product, in: :query, type: :string, required: true
      parameter name: :"person[email]", in: :formData, type: :string, required: true
      parameter name: :"person[username]", in: :formData, type: :string, required: true
      parameter name: :"person[password]", in: :formData, type: :string, required: true
      parameter name: :"person[picture]", in: :formData,  type: :file


      let(:product) { }
      let("person[picture]") {  }
      let("person[email]") { Faker::Internet.email }
      let("person[username]") { "SomeValidUsername" }
      let("person[password]") { Faker::Internet.password }

      response "200", "" do
        schema "$ref": "#/definitions/session_jwt"
        let(:product) { create(:product).internal_name }
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

  #path "/people/{id}" do
  #  patch "" do
  #    tags ["users", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    context "first" do
  #
  #      response "200", "" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #    end
  #    context "sal" do
  #
  #      response "200", "" do
  #        run_test!
  #      end
  #      response "401", "" do
  #        run_test!
  #      end
  #      response "404", "" do
  #        run_test!
  #      end
  #    end
  #  end
  # 
  #  get "" do
  #    tags ["quests", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  #  patch "" do
  #    tags ["quests", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  #end
  #
  #path "/people/{id}/change_password" do
  #  patch "" do
  #    tags ["users", 'android-old']
  #
  #    produces "application/vnd.api.v4+json"
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #    response "401", "" do
  #      run_test!
  #    end
  #    response "404", "" do
  #      run_test!
  #    end
  #  end
  #end
end
