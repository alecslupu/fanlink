# frozen_string_literal: true

module Api
  module V1
    class FollowingsController < ApiController
      load_up_the Person, from: :followed_id, into: :@followed, except: %i[destroy index]
      load_up_the Following, except: %i[create index]

      # **
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
      # *

      def create
        @following = current_user.follow(@followed)
        return_the @following
      end

      # **
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
      # *

      def destroy
        @following.destroy
        head :ok
      end

      # **
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
      # *

      def index
        followed_id = params[:followed_id].to_i
        if followed_id > 0
          followed = Person.find(followed_id)
          @followers = followed.followers
          return_the @followers
        else
          follower_id = params[:follower_id].to_i
          follower = (follower_id > 0) ? Person.find(follower_id) : current_user
          @following = follower.following
          return_the @following
        end
      end
    end
  end
end
