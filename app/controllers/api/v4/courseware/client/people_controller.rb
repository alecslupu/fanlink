class Api::V4::Courseware::Client::PeopleController < Api::V4::Courseware::Client::BaseController
  # frozen_string_literal: true

  def index
    @assignees = current_user.assignees
    return_the @assignees, handler: :jb
  end
end
