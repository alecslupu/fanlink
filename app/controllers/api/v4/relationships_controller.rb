# frozen_string_literal: true

module Api
  module V4
    class RelationshipsController < Api::V3::RelationshipsController
      def index
        if params[:with_id]
          @relationships = Relationship.for_people(current_user, Person.find(params[:with_id]))
        else
          person = (params[:person_id].present?) ? Person.find(params[:person_id]) : current_user
          if person == current_user
            update_relationship_count(current_user, @api_version) # FLAPI-89
          end
          @relationships = Relationship.friended.for_person(person)
          if person == current_user
            @relationships += Relationship.pending_to_person(person)
          end
        end
        return_the @relationships, handler: tpl_handler
      end

      def show
        @relationship = current_user.relationships.find(params[:id])
        return_the @relationship, handler: tpl_handler
      end

      def create
        requested_to = Person.find(relationship_params[:requested_to_id])
        if check_blocked(requested_to)
          @relationship = Relationship.for_people(current_user, requested_to).first
          if @relationship
            if @relationship.requested? && @relationship.requested_by == requested_to
              @relationship.friended!
              update_relationship_count(current_user, @api_version)
              @relationship.friend_request_accepted_push
            end
          else
            @relationship = Relationship.create(requested_by_id: current_user.id, requested_to_id: requested_to.id)
            if @relationship.valid?
              update_relationship_count(@relationship.requested_to, @api_version)
              @relationship.friend_request_received_push
              return_the @relationship, handler: tpl_handler, using: :show
            else
              render_422 @relationship.errors
            end
          end
        else
          render_422(_('You have blocked this person or this person has blocked you.')) && return
        end
      end

      def update
        if params.has_key?(:relationship)
          if check_status
            if current_user.relationships.include?(@relationship)
              old_status = @relationship.status
              new_status = relationship_params[:status]
              can_status = true
              # TODO: simplify this mess
              if new_status == 'friended'
                if old_status == 'requested' && @relationship.requested_to == current_user
                  ActiveRecord::Base.connection_pool.with_connection do
                    @relationship.friended!
                    update_relationship_count(current_user, @api_version)
                    @relationship.friend_request_accepted_push
                  end
                else
                  can_status = false
                end
              elsif new_status == 'denied'
                if old_status == 'requested' && @relationship.requested_to == current_user
                  @relationship.destroy
                  update_relationship_count(current_user, @api_version)
                else
                  can_status = false
                end
              else # withdrawn
                if old_status == 'requested' && @relationship.requested_by == current_user
                  @relationship.destroy
                  update_relationship_count(@relationship.requested_to, @api_version)
                else
                  can_status = false
                end
              end
              if can_status
                if @relationship.destroyed?
                  head :ok
                else
                  return_the @relationship, handler: tpl_handler, using: :show
                end
              else
                render_422('You cannot change to the relationship to that status.')
              end
            else
              render_not_found
            end
          else
            render_error('That status is invalid')
          end
        else
          return_the @relationship, handler: tpl_handler, using: :show
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
