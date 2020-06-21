# frozen_string_literal: true

class Api::V4::Trivia::GameLeaderboardsController < ApiController
  def index
    @leaderboard = paginate(::Trivia::Game.find(params[:game_id]).leaderboards)
    return_the @leaderboard, handler: :jb
  end

  def me
    @leaderboard = ::Trivia::Game.find(params[:game_id]).leaderboards.where(person_id: current_user.id).first_or_initialize
    return_the @leaderboard, handler: :jb
  end
end
