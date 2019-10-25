class Api::V4::Courseware::Client::PeopleController < ApiController
  def index
    if current_user.client?
      @assignees = current_user.assignees
      # return the @assignees
    else
      render_401 _("You must have 'client' role to access this feature.")
    end
  end

  private
  def person_params
    params.require(:person).permit(:client_id)
  end
end
