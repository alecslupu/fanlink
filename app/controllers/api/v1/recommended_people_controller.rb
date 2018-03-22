class Api::V1::RecommendedPeopleController < ApiController
  #**
  # @api {get} /people/recommended Get recommended people.
  # @apiName GetRecommendedPeople
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to get a list of people flagged as 'recommended'. It excludes the current user and anyone
  #   the current user is following.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #   "recommended_people" {
  #     [ ... person json ...],
  #     ....
  #   }
  #*
  def index
    @people = Person.where(recommended: true).where.not(id: current_user).where.not(id: current_user.following)
    return_the @people
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
    @relationship = current_user.relationships.find(params[:id])
    return_the @relationship
  end

  #**
  # @api {patch} /relationships Update a relationship.
  # @apiName UpdateRelationship
  # @apiGroup Relationships
  #
  # @apiDescription
  #   This is used to accept, deny or unfriend a relationship (friend request).
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
      if current_user.relationships.include?(@relationship)
        old_status = @relationship.status
        new_status = relationship_params[:status]
        can_status = true
        #TODO: yeah this is a mess
        if new_status == "friended"
          if old_status == "requested" && @relationship.requested_to == current_user
            @relationship.friended!
            update_relationship_count(current_user)
            friend_request_accepted_push(@relationship)
          else
            can_status = false
          end
        elsif new_status == "denied"
          if old_status == "requested" && @relationship.requested_to == current_user
            @relationship.destroy
            update_relationship_count(current_user)
          else
            can_status = false
          end
        else #withdrawn
          if old_status == "requested" && @relationship.requested_by == current_user
            @relationship.destroy
            update_relationship_count(@relationship.requested_to)
          else
            can_status = false
          end
        end
        if can_status
          if @relationship.destroyed?
            head :ok
          else
            return_the @relationship
          end
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
    ["friended", "denied", "withdrawn"].include?(relationship_params[:status])
  end

  def relationship_params
    params.require(:relationship).permit(:requested_to_id, :status)
  end
end
