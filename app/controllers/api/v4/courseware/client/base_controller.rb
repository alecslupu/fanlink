class Api::V4::Courseware::Client::BaseController < ApiController
  before_action :authorize_person

  private

  def authorize_person
    return render_401 _("You must have the 'client' role to access this feature.") unless current_user.client?
  end
end
