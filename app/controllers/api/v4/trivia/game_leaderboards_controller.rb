class Api::V4::Trivia::GameLeaderboardsController < ApiController
  def index
    @leaderboard = paginate(::Trivia::GameLeaderboard.all)
    return_the @leaderboard, handler: 'jb'
  end

  def me
    @leaderboard  = ::Trivia::GameLeaderboard.where(person_id: current_user.id).last
    return_the @leaderboard, handler: 'jb'
  end
end
