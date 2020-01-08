require "swagger_helper"

RSpec.describe "Api::V4::SessionController", type: :request, swagger_doc: "v4/swagger.json" do
  #path "/session/token" do
  #  post "generates a  valid JWT" do
  #    tags "Session"
  #    produces "application/vnd.api.v4+json"
  #
  #    consumes "multipart/form-data"
  #    parameter name: :email_or_username, in: :formData, schema: {type: :string}
  #    parameter name: :password, in: :formData, schema: {type: :string}
  #    parameter name: :product, in: :formData, schema: {type: :string}
  #    # parameter name: "X-App", in: :header, type: :string
  #    # parameter name: "X-Current-Product", in: :header, type: :string
  #
  #    response "200", "" do
  #      let!(:user) { create(:person) }
  #      let(:email_or_username) { user.email }
  #      let(:password) { "badpassword"}
  #      let(:product) { user.product.internal_name }
  #      schema "$ref": "#/definitions/session_jwt"
  #      run_test!
  #    end
  #
  #    response 422, "Invalid login" do
  #      let!(:user) { create(:person) }
  #      let(:email_or_username) { "a" + user.email }
  #      let(:password) { "bad_password" }
  #      let(:product) { user.product.internal_name }
  #      run_test!
  #    end
  #  end
  #end
  #
  #path "/session" do
  #
  #  post "Used to log someone in" do
  #    tags "Session"
  #    produces "application/vnd.api.v4+json"
  #    consumes "multipart/form-data"
  #    parameter name: :product, in: :formData,  schema: {type: :string}
  #    parameter name: :facebook_auth_token, in: :formData, schema: {type: :string}, required: false
  #    parameter name: :password, in: :formData,schema: {type: :string}, required: false
  #    parameter name: :email_or_username, in: :formData, schema: {type: :string}, required: false
  #
  #    response "200", "Returns an user object if successful" do
  #      schema "$ref": "#/definitions/session_jwt"
  #
  #      before do |example|
  #        submit_request(example.metadata)
  #        koala_result = {"id" => "2905623", "name" => "John Smith", "email" => "no@email.tld"}
  #        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object).and_return(koala_result)
  #      end
  #
  #      let!(:user) { create(:person, facebookid: "2905623") }
  #      let(:product) { user.product.internal_name }
  #
  #      context "facebook login " do
  #        let(:facebook_auth_token) { 'some token' }
  #        run_test!
  #      end
  #
  #      context "username login" do
  #        let(:email_or_username) { user.email }
  #        let(:password) { "badpassword" }
  #        run_test!
  #      end
  #    end
  #
  #    response 422, "Invalid login" do
  #      let!(:user) { create(:person) }
  #      let(:facebook_auth_token) { '' }
  #      let(:product) { user.product.internal_name }
  #      run_test!
  #    end
  #
  #    response 500, "Internal server error" do
  #      let!(:user) { create(:person, facebookid: "2905623") }
  #      let(:product) { user.product.internal_name }
  #      before do |example|
  #        submit_request(example.metadata)
  #      end
  #      let(:facebook_auth_token) { 'some token' }
  #      run_test!
  #    end
  #
  #  end
  #
  #  delete "Log someone out" do
  #    tags "Session"
  #    produces "application/vnd.api.v4+json"
  #
  #    response "200", "" do
  #      run_test!
  #    end
  #  end
  #end
end

