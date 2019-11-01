class Api::V4::Courseware::Client::PeopleController < ApiController
  def index
    if current_user.client?
      id = Person.last.nil? ? 1 : Person.last.id
      if params[:username_filter].present?
        @assignees = paginate (Person.all.username_filter_courseware(params[:username_filter]).order(:username))
      else
        @assignees = paginate (Person.all.order(:username))
      end
      return_the @assignees, handler: :jb
    else
      render_401 _("You must have 'client' role to access this feature.")
    end
  end
end
