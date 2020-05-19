# frozen_string_literal: true
require "swagger_helper"

RSpec.describe "Api::V4::Trivia::RoundsController", type: :request, swagger_doc: "v4/swagger.json" do
  #path "/trivia/games/{game_id}/rounds" do
  #  get "displays complete leaderboard" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-Per-Page", in: :header, schema: {type: :integer}
  #    parameter name: "X-Page", in: :header, schema: {type: :integer}
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header,schema: {type: :string}
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_round_list"
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
  #path "/trivia/games/{game_id}/rounds/{round_id}/change_status" do
  #  post "Changes the status of a round" do
  #    tags "Trivia"
  #    produces "application/vnd.api.v4+json"
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: :round_id, in: :path, schema: {type: :integer}
  #    parameter name: :token, in: :formData, schema: {type: :string}
  #    parameter name: :status, in: :formData, schema: {type: :string}, enum: [:locked, :published, :running]
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { create(:person) }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
end
