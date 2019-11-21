class Api::V4::Courseware::Client::BaseController < ApiController
  # frozen_string_literal: true

  before_action :authorize_person
  before_action :check_if_clients_assignee

  protected
  def assignee_ids
    current_user.hired_people.pluck(:person_id)
  end

  private

  def authorize_person
    raise AccessDeniedException.new _("You must have the 'client' role to access this feature.") unless current_user.client?
  end

  def check_if_clients_assignee
    raise AccessDeniedException.new _("You need to supply a person_id.") unless params[:person_id].present?
    raise AccessDeniedException.new _("You can only see your assignee's info.") unless assignee_ids.include?(params[:person_id].to_i)
  end
end
