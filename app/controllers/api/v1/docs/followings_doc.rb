class Api::V1::Docs::FollowingsDoc < Api::V1::Docs::BaseDoc
  #**
  # @api {post} /followings Follow a person.
  # @apiName CreateFollowing
  # @apiGroup Following
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to follow a person.
  #
  # @apiParam (body) {Integer} followed_id
  #   Person to follow
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "following": {
  #       "id" : 123, #id of the following
  #       "follower" : { ...public json of the person following },
  #       "followed" : { ...public json of the person followed }
  #     }
  #
  #*

  #**
  # @api {delete} /followings/:id Unfollow a person.
  # @apiName DeleteFollowing
  # @apiGroup Following
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to unfollow a person.
  #
  # @apiParam (path) {Integer} id
  #   id of the underlying following
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #*

  #**
  # @api {get} /followings Get followers or followings of a user.
  # @apiName GetFollowings
  # @apiGroup Following
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to get a list of someone's followers or followed. If followed_id parameter
  #   is supplied, it will get the follower's of that user. If follower_id is supplied,
  #   it will get the people that person is following. If nothing is supplied, it will
  #   get the people the current user is following.
  #
  # @apiParam (body) {Integer} followed_id
  #   Person to who's followers to get
  #
  # @apiParam (body) {Integer} follower_id
  #   Id of person who is following the people in the list we are getting.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #   "followers [or following]" {
  #     [ ... person json of follower/followed....],
  #     ....
  #   }
  #*
  doc_tag name: 'Followings', desc: "Followers and following"
  route_base 'api/v1/followings'

  components do
    resp :FollowingsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :followings => [
        :following => :Following
      ]
    }]
    resp :FollowersArray => ['HTTP/1.1 200 Ok', :json, data:{
      :followers => [
        :follower => :Following
      ]
    }]
  end

end
