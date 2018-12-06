class Api::V4::PeopleController < Api::V3::PeopleController
  def index
    @people = paginate apply_filters
    @people = @people.reject {|person| person==current_user}
    return_the @people, handler: 'jb'
  end

  def show
    if current_user.blocks_by.where(blocked_id: params[:id]).exists?
      render_not_found
    else
      if params.has_key?(:username)
        @person = Person.where(username: params[:username]).first
      else
        @person = Person.find(params[:id])
      end
      return_the @person, handler: 'jb'
    end
  end

  def create
    if !check_gender
      render_error("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}")
    else
      parms = person_params
      if params[:facebook_auth_token].present?
        @person = Person.create_from_facebook(params[:facebook_auth_token], parms[:username])
        if @person.nil?
          (render json: { errors: _("There was a problem contacting Facebook.") }, status: :service_unavailable) && return
        end
      else
        @person = Person.create(person_params)
      end
      if @person.valid?
        @person.do_auto_follows
        auto_login(@person)
        if @person.email.present?
          @person.send_onboarding_email
        end
        return_the @person, handler: 'jb', using: :show
      else
        render_422 @person.errors
      end
    end
  end

  def update
    if params.has_key?(:person)
      if !check_gender
        render_422("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}")
      else
        if @person == current_user || current_user.some_admin? || current_user.product_account
          if person_params.has_key?(:terminated) && @person.some_admin?
            return render_422 _("You cannot ban administative accounts.")
          end
          @person.update(person_params)
          if @person.terminated && @person == current_user
            logout
            cookies.delete :_fanlink_session
            return render_401 _("Your account has been banned.")
          else
            return_the @person, handler: 'jb', using: :show
          end
        else
          render_not_found
        end
      end
    else
      return_the @person, handler: 'jb', using: :show
    end
  end

  def stats
    if params.has_key?(:days) && params[:days].respond_to?(:to_i)
      time = params[:days].to_i
    else
      time = 1
    end
    @people = Person.where("created_at >= ?", time.day.ago).order("DATE(created_at) ASC").group("Date(created_at)").count
    return_the @people, handler: 'jb'
  end

end
