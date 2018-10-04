class Api::V4::FollowingsController < Api::V3::FollowingsController
  def index
    followed_id = params[:followed_id].to_i
    if followed_id > 0
      followed = Person.find(followed_id)
      @followers = followed.followers
      return_the paginate(@followers)
    else
      follower_id = params[:follower_id].to_i
      follower = (follower_id > 0) ? Person.find(follower_id) : current_user
      @following = follower.following
      return_the paginate(@following)
    end
  end
end
