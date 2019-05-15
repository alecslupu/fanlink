require "swagger_helper"

RSpec.describe "Api::V4::Trivia::SubscriptionsController", type: :request, swagger_doc: "v4/swagger.json" do

  #
  # path "/trivia/games/completed" do
  #
  #   get "displays completed games" do
  #     tags "Trivia"
  #     security [Bearer: []]
  #     produces "application/vnd.api.v4+json"
  #     parameter name: 'X-Per-Page', :in => :header, :type => :integer
  #     parameter name: 'X-Page', :in => :header, :type => :integer
  #     response "200", "displays completed games" do
  #       let(:user) { create(:person) }
  #       let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
  #       let!(:games) { ActsAsTenant.with_tenant(user.product) {
  #         create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
  #       }}
  #       schema "$ref": "#/definitions/trivia_games_list"
  #       run_test!
  #     end
  #     response "401", "unauthorized" do
  #       let(:user) { create(:person, terminated: true) }
  #       let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
  #       let!(:games) { ActsAsTenant.with_tenant(user.product) {
  #         create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
  #       }}
  #       run_test!
  #     end
  #   end
  # end
  #
  #
  # path "/trivia/games" do
  #   get "displays future and on going games" do
  #     tags "Trivia"
  #     security [Bearer: []]
  #     produces "application/vnd.api.v4+json"
  #     parameter name: 'X-Per-Page', :in => :header, :type => :integer
  #     parameter name: 'X-Page', :in => :header, :type => :integer
  #     response "200", "displays future and on going games" do
  #       schema "$ref": "#/definitions/trivia_games_list"
  #       let(:user) { create(:person) }
  #       let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
  #       let!(:games) { ActsAsTenant.with_tenant(user.product) {
  #         create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i + 100)
  #       }}
  #       run_test!
  #     end
  #
  #     response "401", "unauthorized" do
  #       let(:user) { create(:person, terminated: true ) }
  #       let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
  #       let!(:games) { ActsAsTenant.with_tenant(user.product) {
  #         create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
  #       }}
  #       run_test!
  #     end
  #   end
  # end
end

=begin
class Api::V4::Trivia::GameLeaderboardsController < ApiController
  def index
    @leaderboard = paginate(::Trivia::Game.find(params[:game_id]).leaderboards)
    return_the @leaderboard, handler: :jb
  end

  def me
    @leaderboard = ::Trivia::Game.find(params[:game_id]).leaderboards.where(person_id: current_user.id).last
    return_the @leaderboard, handler: :jb
  end
end

=end
