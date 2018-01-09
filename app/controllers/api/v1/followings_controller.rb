class Api::V1::FollowingsController < ApiController

  load_up_the Person, from: :followed_id, into: :@followed

  #**
  # @api {post} /followings Follow a person.
  # @apiName CreateFollowing
  # @apiGroup Following
  #
  # @apiDescription
  #   This is used to follow a person.
  #
  # @apiParam {Integer} followed_id
  #   Person to follow
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "followed": { the public json of the person followed }
  #*
  def create
    current_user.follow(@followed)
    return_the @followed
  end

  #**
  # @api {delete} /followings Unfollow a person.
  # @apiName DeleteFollowing
  # @apiGroup Following
  #
  # @apiDescription
  #   This is used to unfollow a person.
  #
  # @apiParam {Integer} followed_id
  #   Person to unfollow
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #*
  def destroy
    current_user.unfollow(@followed)
    head :ok
  end

end