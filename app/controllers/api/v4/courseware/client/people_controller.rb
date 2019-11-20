class Api::V4::Courseware::Client::PeopleController < Api::V4::Courseware::Client::BaseController
  # frozen_string_literal: true

  def index
    if params[:username_filter].present?
      @assignees = paginate (current_user.assignees.username_filter(params[:username_filter], current_user))
    else
      @assignees = paginate (current_user.assignees)
    end
    return_the @assignees, handler: :jb
  end
end
