class Api::V4::Trivia::PackageLeaderboardsController < ApiController
  def index
    @leaderboard = paginate(::Trivia::PackageLeaderboard.all)
    return_the @leaderboard, handler: 'jb'
  end

  def me
    @leaderboard  = ::Trivia::PackageLeaderboard.where(person_id: current_user.id).last
    return_the @leaderboard, handler: 'jb'
  end
end
