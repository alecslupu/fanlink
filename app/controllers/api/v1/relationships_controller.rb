class Api::V1::RelationshipsController < ApiController
  include Messaging

  load_up_the Person, from: :requested_to_id, into: :@requested, only: %i[ create ]
  load_up_the Relationship, except: %i[ create index ]

  #**
  # @api {post} /relationships Send a friend request to a person.
  # @apiName CreateRelationship
  # @apiGroup Relationships
  #
  # @apiDescription
  #   This is used to send a friend request to a person. You can send one to anyone unless
  #   there is a current unresolved request outstanding. Unresolved means it has
  #   status of requested or friended
  #
  # @apiParam {Object} relationship
  #   Relationship object.
  #
  # @apiParam {Integer} relationship.requested_to_id
  #   Person for whom the request is intended
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "relationship": {
  #       "id" : 123, #id of the relationship
  #       "requested_by" : { ...public json of the person requesting },
  #       "requested_to" : { ...public json of the person requested }
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "You already spammed that person, blah blah blah" }
  #*
  def create
    requested_to = Person.find(relationship_params[:requested_to_id])
    @relationship = Relationship.create(requested_by_id: current_user.id, requested_to_id: requested_to.id)
    if @relationship.valid?
      post_relationship(@relationship)
    end
    return_the @relationship
  end

  #**
  # @api {delete} /followings/:id Unfollow a person.
  # @apiName DeleteFollowing
  # @apiGroup Following
  #
  # @apiDescription
  #   This is used to unfollow a person.
  #
  # @apiParam {Integer} id
  #   id of the underlying following
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #*
  def destroy
    @following.destroy
    head :ok
  end

  #**
  # @api {get} /followings Get followers or followings of a user.
  # @apiName GetFollowings
  # @apiGroup Following
  #
  # @apiDescription
  #   This is used to get a list of someone's followers or followed. If followed_id parameter
  #   is supplied, it will get the follower's of that user. If follower_id is supplied,
  #   it will get the people that person is following. If nothing is supplied, it will
  #   get the people the current user is following.
  #
  # @apiParam {Integer} followed_id
  #   Person to who's followers to get
  #
  # @apiParam {Integer} follower_id
  #   Id of person who is following the people in the list we are getting.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #   "followers [or following]" {
  #     [ ... person json of follower/followed....],
  #     ....
  #   }
  #*
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

  #**
  # @api {get} /relationships/:id Get a single relationship.
  # @apiName GetRelationship
  # @apiGroup Relationships
  #
  # @apiDescription
  #   This gets a single relationship for a relationship id. Only available to a participating user.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "relationship": {
  #         "id": "5016",
  #         "status": "requested",
  #         "created_time": "2018-01-08'T'12:13:42'Z'",
  #         "update_time": "2018-01-08'T'12:13:42'Z'",
  #         "requested_by": { ... public person json },
  #         "requested_to": { ... public person json }
  #      }
  #
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  def show
    @relationship = current_user.relationships.visible.find(params[:id])
    return_the @relationship
  end

  #**
  # @api {patch} /relationships Send a friend request to a person.
  # @apiName UpdateRelationship
  # @apiGroup Relationships
  #
  # @apiDescription
  #   This is used to accept, deny or cancel a relationship (friend request).
  #
  # @apiParam {Object} relationship
  #   Relationship object.
  #
  # @apiParam {Integer} relationship.status
  #   New status. Valid values are "friended", "denied" or "withdrawn". However each one is only
  #   valid in the state and/or from the person that you would expect (e.g. the relationship
  #   requester cannot update with "friended").
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "relationship": {
  #       "id" : 123, #id of the relationship
  #       "status": "friended"
  #       "create_time": ""2018-01-08'T'12:13:42'Z'""
  #       "updated_time": ""2018-01-08'T'12:13:42'Z'""
  #       "requested_by" : { ...public json of the person requesting },
  #       "requested_to" : { ...public json of the person requested }
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "You can't friend your own request, blah blah blah" }
  #*
  def update
    requested_to = Person.find(relationship_params[:requested_to_id])
    @relationship = Relationship.create(requested_by_id: current_user.id, requested_to_id: requested_to.id)
    if @relationship.valid?
      post_relationship(@relationship)
    end
    return_the @relationship
  end

  private

  def relationship_params
    params.require(:relationship).permit(:requested_to_id)
  end
end
