class Api::V4::Courseware::Client::BaseController < ApiController
  before_action :authorize_person
  before_action :check_if_clients_assignee

  private

  def authorize_person
    return render_401 _("You must have the 'client' role to access this feature.") unless current_user.client?
  end

  def check_if_clients_assignee
    binding.pry
    if params[:person_id].present? && Person.find(params[:person_id]).assigners.exclude?(current_user)
      return render_401 _("You can only see your assignee's info.")
    end
  end
end
