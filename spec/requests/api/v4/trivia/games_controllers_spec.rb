require "swagger_helper"

RSpec.describe "Api::V4::Trivia::GamesControllers", type: :request, swagger_doc: "v4/swagger.json" do
  #path "/trivia/games/completed" do
  #  get "displays completed games" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-Per-Page", in: :header, schema: {type: :integer}
  #    parameter name: "X-Page", in: :header, schema: {type: :integer}
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_games_list"
  #      run_test!
  #    end
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
  #
  #path "/trivia/games" do
  #  get "displays future and on going games" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-Per-Page", in: :header, schema: {type: :integer}
  #    parameter name: "X-Page", in: :header, schema: {type: :integer}
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #    response "200", "HTTP/1.1 200 Ok" do
  #      schema "$ref": "#/definitions/trivia_games_list"
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i + 100)
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
  #          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
end
