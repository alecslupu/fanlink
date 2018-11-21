class Api::V4::FollowingsController < Api::V3::FollowingsController
  def index
    followed_id = params[:followed_id].to_i
    if followed_id > 0
      followed = Person.find(followed_id)
      @followers = paginate followed.followers
      return_the @followers, handler: 'jb'
    else
      follower_id = params[:follower_id].to_i
      follower = (follower_id > 0) ? Person.find(follower_id) : current_user
      @following = paginate follower.following
      return_the @following, handler: 'jb'
    end
  end

  def create
    @following = current_user.follow(@followed)
    return_the @following, handler: 'jb', using: :show
  end
end
