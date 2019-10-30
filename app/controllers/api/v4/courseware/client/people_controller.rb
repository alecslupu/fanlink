class Api::V4::Courseware::Client::PeopleController < ApiController
  # frozen_string_literal: true

  def index
    if current_user.client?
      @assignees = current_user.assignees
      return_the @assignees, handler: :jb
    else
      render_401 _("You must have 'client' role to access this feature.")
    end
  end
end
