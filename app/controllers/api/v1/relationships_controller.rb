class Api::V1::RelationshipsController < ApiController
  include Messaging

  load_up_the Relationship, except: %i[ create index ]

  #**
  # @api {post} /relationships Send a friend request to a person.
  # @apiName CreateRelationship
  # @apiGroup Relationships
  #
  # @apiDescription
  #   This is used to send a friend request to a person. You can send one to anyone unless
  #   there is a current unresolved request outstanding. Unresolved means it has
  #   status of requested or friended.
  #
  #   If the person sending the request already has a pending request from the requested_to_id, then no additional
  #   records will be created. The original relationship will be changed to friended and returned.
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
    if check_blocked(requested_to)
      @relationship = Relationship.find_by(requested_to: current_user, requested_by: requested_to, status: :requested)
      if @relationship
        @relationship.status = :friended
        @relationship.requested_to.friend_request_count -= 1
        if update_relationship_count(@relationship.requested_to)
          @relationship.save!
          @relationship.requested_to.save
        else
          @relationship.errors.add(:base, "There was a problem transmitting the friend request. Please try again laster.")
        end
      else
        @relationship = Relationship.create(requested_by_id: current_user.id, requested_to_id: requested_to.id)
        if @relationship.valid?
          @relationship.requested_to.friend_request_count += 1
          if update_relationship_count(@relationship.requested_to)
            @relationship.requested_to.save
          else
            @relationship.errors.add(:base, "There was a problem transmitting the friend request. Please try again laster.")
          end
        end
      end
      return_the @relationship.reload
    else
      render_error("You have blocked this person or this person has blocked you.") && return
    end
  end

  #**
  # @api {delete} /relationships/:id Unfriend a person.
  # @apiName DeleteRelationship
  # @apiGroup Relationship
  #
  # @apiDescription
  #   This is used to unfriend a person.
  #
  # @apiParam {Integer} id
  #   id of the underlying relationship
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #*
  def destroy
    if current_user.can_status?(@relationship, :unfriended)
      @relationship.status = :unfriended
      @relationship.save
      if @relationship.valid?
        head :ok
      else
        render_error("Sorry, you cannot unfriend that person right now.")
      end
    else
      render_not_found
    end
  end

  #**
  # @api {get} /relationships Get current relationships of a person.
  # @apiName GetRelationships
  # @apiGroup Relationships
  #
  # @apiDescription
  #   This is used to get a list of someone's friends. If the person supplied is
  #   the logged in user, 'requested' status is included for requests TO the current
  #   user. Otherwise, only 'friended' status is included.
  #
  # @apiParam {Integer} [person_id]
  #   Person whose friends to get
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #   "relationships" {
  #     [ ... relationship json ...],
  #     ....
  #   }
  #*
  def index
    person = (params[:person_id].present?) ? Person.find(params[:person_id]) : current_user
    @relationships = Relationship.friended.for_person(person)
    if person == current_user
      @relationships += Relationship.pending_to_person(person)
    end
    return_the @relationships
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
  # @api {patch} /relationships Update a relationship.
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
    if check_status
      if current_user.relationships.visible.include?(@relationship)
        old_status = @relationship.status
        new_status = relationship_params[:status]
        if current_user.can_status?(@relationship, new_status)
          @relationship.status = relationship_params[:status]
          if @relationship.save && Relationship.counted_transition?(old_status.to_sym)
            @relationship.requested_to.friend_request_count -= 1
            if update_relationship_count(@relationship.requested_to)
              @relationship.requested_to.save!
            end
          end
          return_the @relationship
        else
          render_error("You cannot change to the relationship to that status.")
        end
      else
        render_not_found
      end
    else
      render_error("That status is invalid")
    end
  end

private

  def check_blocked(person)
    !current_user.block_with?(person)
  end

  def check_status
    Relationship.statuses.keys.include?(relationship_params[:status])
  end

  def relationship_params
    params.require(:relationship).permit(:requested_to_id, :status)
  end
end
