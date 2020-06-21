# frozen_string_literal: true

class Api::V3::RelationshipsController < Api::V2::RelationshipsController
  include Messaging
  load_up_the Relationship, except: %i[ create index ]

  # **
  # @api {post} /relationships Send a friend request to a person.
  # @apiName CreateRelationship
  # @apiGroup Relationships
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to send a friend request to a person. If there is a block between the people, an error will
  #   be returned.
  #
  #   If the person sending the request already has a pending request (or friendship) from the requested_to_id, then no additional
  #   records will be created. The original relationship will be changed to friended (if not already) and returned.
  #
  # @apiParam (body) {Object} relationship
  #   Relationship object.
  #
  # @apiParam (body) {Integer} relationship.requested_to_id
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
  # *

  def create
    requested_to = Person.find(relationship_params[:requested_to_id])
    if check_blocked(requested_to)
      @relationship = Relationship.for_people(current_user, requested_to).first
      if @relationship
        if @relationship.requested? && @relationship.requested_by == requested_to # there was request o/s from this user to us
          @relationship.friended!
          update_relationship_count(current_user)
          @relationship.friend_request_accepted_push
        end
      else
        @relationship = Relationship.create(requested_by_id: current_user.id, requested_to_id: requested_to.id)
        if @relationship.valid?
          update_relationship_count(@relationship.requested_to)
          @relationship.friend_request_received_push
          return_the @relationship
        else
          render_422 @relationship.errors
        end
      end
    else
      render_422(_("You have blocked this person or this person has blocked you.")) && return
    end
  end

  # **
  # @api {delete} /relationships/:id Unfriend a person.
  # @apiName DeleteRelationship
  # @apiGroup Relationship
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to unfriend a person.
  #
  # @apiParam (path) {Integer} id
  #   id of the underlying relationship
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  # *

  def destroy
    if @relationship.person_involved?(current_user) && @relationship.friended?
      if @relationship.destroy
        head :ok
      else
        render_422(_("Sorry, you cannot unfriend that person right now."))
      end
    else
      render_not_found
    end
  end

  # **
  # @api {get} /relationships Get current relationships of a person.
  # @apiName GetRelationships
  # @apiGroup Relationships
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to get a list of someone's friends. If the person supplied is
  #   the logged in user, 'requested' status is included for requests TO the current
  #   user. Otherwise, only 'friended' status is included.
  #
  # @apiParam (body) {Integer} [person_id]
  #   Person whose friends to get
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #   "relationships" {
  #     [ ... relationship json ...],
  #     ....
  #   }
  # *

  def index
    person = (params[:person_id].present?) ? Person.find(params[:person_id]) : current_user
    if person == current_user
      update_relationship_count(current_user) # FLAPI-89
    end
    @relationships = Relationship.friended.for_person(person)
    if person == current_user
      @relationships += Relationship.pending_to_person(person)
    end
    return_the @relationships
  end

  # **
  # @api {get} /relationships/:id Get a single relationship.
  # @apiName GetRelationship
  # @apiGroup Relationships
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a single relationship for a relationship id. Only available to a participating user.
  #
  # @apiParam (path) {Integer} id The relationship ID
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
  # *

  def show
    @relationship = current_user.relationships.find(params[:id])
    return_the @relationship
  end

  # **
  # @api {patch} /relationships Update a relationship.
  # @apiName UpdateRelationship
  # @apiGroup Relationships
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to accept, deny or unfriend a relationship (friend request).
  #
  # @apiParam (body) {Object} relationship
  #   Relationship object.
  #
  # @apiParam (body) {Integer} relationship.status
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
  # *

  def update
    if params.has_key?(:relationship)
      if check_status
        if current_user.relationships.include?(@relationship)
          old_status = @relationship.status
          new_status = relationship_params[:status]
          can_status = true
          # TODO: simplify this mess
          if new_status == "friended"
            if old_status == "requested" && @relationship.requested_to == current_user
              @relationship.friended!
              update_relationship_count(current_user)
              @relationship.friend_request_accepted_push
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
          else # withdrawn
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
            render_422("You cannot change to the relationship to that status.")
          end
        else
          render_not_found
        end
      else
        render_error("That status is invalid")
      end
    else
      return_the @relationship
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
