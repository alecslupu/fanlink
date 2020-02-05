require "swagger_helper"

RSpec.describe "Api::V4::Trivia::SubscriptionsController", type: :request, swagger_doc: "v4/swagger.json" do
  #path "/trivia/games/{game_id}/subscription" do
  #  get "Show the subscription information" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_user_subscribed"
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      run_test!
  #    end
  #
  #    response "404", "not found" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      run_test!
  #    end
  #  end
  #
  #  delete "remove a subscription" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    response "204", "displays completed games" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      run_test!
  #    end
  #
  #    response "404", "not found" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      run_test!
  #    end
  #  end
  #  put "updates the subscription information" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: :subscribed, in: :formData, schema: {type: :boolean}
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_user_subscribed"
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      run_test!
  #    end
  #
  #    response "404", "not found" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      run_test!
  #    end
  #  end
  #  post "creates the subscription information" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header,schema: {type: :string}
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: :subscribed, in: :formData, schema: {type: :boolean}
  #
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_user_subscribed"
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create(:trivia_subscriber, person: user)
  #        }
  #      }
  #      run_test!
  #    end
  #
  #    response "404", "not found" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      run_test!
  #    end
  #  end
  #end
end
