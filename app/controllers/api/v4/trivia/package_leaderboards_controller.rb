class Api::V4::Trivia::PackageLeaderboardsController < ApiController

  def index
    @leaderboard = paginate(package)
    return_the @leaderboard, handler: :jb
  end

  def me
    @leaderboard  = package.where(person_id: current_user.id).last
    return_the @leaderboard, handler: :jb
  end

  protected
    def package
      @package ||= ::Trivia::Game.find(params[:game_id]).packages.published.find(params[:package_id]).leaderboards
    end

end
