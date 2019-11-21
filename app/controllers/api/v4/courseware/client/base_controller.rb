class Api::V4::Courseware::Client::BaseController < ApiController
  # frozen_string_literal: true

  before_action :authorize_person
  before_action :check_if_clients_assignee

  private

    def authorize_person
      render_401 _("You must have the 'client' role to access this feature.") unless current_user.client?
    end

    def check_if_clients_assignee
      if Courseware::Client::ClientToPerson.where(client_id: current_user.id, user_id: params[:person]).blank?
        render_401 _("You can only see your assignee's info.")
      end
    end
end
