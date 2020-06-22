# frozen_string_literal: true

require 'swagger_helper'


RSpec.describe 'Api::V4::Trivia::RoundLeaderboardsController', type: :request, swagger_doc: 'v4/swagger.json' do
  #path "/trivia/games/{game_id}/leaderboard/me" do
  #  get "displays my possition leaderboard" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #
  #    let('X-Per-Page') { 2 }
  #    let('X-App') { 'app' }
  #    let('X-Page') { 1 }
  #    let(:product) { create(:product) }
  #    let('X-Current-Product') { product.internal_name }
  #    let!(:game) { ActsAsTenant.with_tenant(product) { create(:full_short_trivia_game, with_leaderboard: true) } }
  #    let!(:game_id) { game.id }
  #
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { ActsAsTenant.with_tenant(product) { create(:person) } }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #
  #      schema "$ref": "#/definitions/trivia_games_leaderboard"
  #
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
  #path "/trivia/games/{game_id}/leaderboard" do
  #  get "displays complete leaderboard" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-Per-Page", in: :header, schema: {type: :integer}
  #    parameter name: "X-Page", in: :header, schema: {type: :integer}
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #
  #    let('X-Per-Page') { 2 }
  #    let('X-Page') { 1 }
  #    let('X-App') { 'app' }
  #    let(:product) { create(:product) }
  #    let('X-Current-Product') { product.internal_name }
  #    let!(:game) { ActsAsTenant.with_tenant(product) { create(:full_short_trivia_game, with_leaderboard: true) } }
  #    let!(:game_id) { game.id }
  #
  #
  #    response "200", "HTTP/1.1 200 Ok" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_games_leaderboard_list"
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
end
