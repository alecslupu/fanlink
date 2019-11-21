class Api::V4::Courseware::Client::PeopleController < Api::V4::Courseware::Client::BaseController
  # frozen_string_literal: true

  skip_before_action :check_if_clients_assignee

  def index
    @assignees = Person.where(id: assignee_ids)
    @assignees = @assignees.username_filter(params[:username_filter], current_user) if params[:username_filter].present?

    @assignees = paginate(@assignees)
    return_the( @assignees, handler: :jb)
  end
end



