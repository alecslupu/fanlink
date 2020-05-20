# frozen_string_literal: true
class Api::V4::Trivia::RoundLeaderboardsController < ApiController
  def index
    @leaderboard = paginate(package)
    return_the @leaderboard, handler: :jb
  end

  def me
    @leaderboard = package.where(person_id: current_user.id).first_or_initialize
    return_the @leaderboard, handler: :jb
  end

  protected
    def package
      @package ||= ::Trivia::Game.find(params[:game_id]).rounds.find(params[:round_id]).leaderboards
    end
end
