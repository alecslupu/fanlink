# frozen_string_literal: true

class Api::V4::PeopleController < Api::V3::PeopleController
  def index
    @people = paginate apply_filters
    @people = @people.reject { |person| person == current_user } unless params[:product_account_filter]
    return_the @people, handler: tpl_handler
  end

  def show
    if current_user.blocks_by.where(blocked_id: params[:id]).exists?
      render_not_found
    else
      if params.has_key?(:username)
        @person = Person.for_username(params[:username])
      else
        @person = Person.find(params[:id])
      end
      return_the @person, handler: tpl_handler
    end
  end

  def create
    if params.has_key?(:person)
      if !check_gender
        render_error("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}")
      else
        if params[:facebook_auth_token].present?
          @person = Person.create_from_facebook(params[:facebook_auth_token], person_params[:username])
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

          params_hash = params.except(:controller, :action, :format ).to_unsafe_h
          params_hash[:person].delete(:password)
          params_hash[:person].delete(:picture)
          broadcast(:person_created, @person.id, params_hash)

          return_the @person, handler: tpl_handler
        else
          render_422 @person.errors
        end
      end
    else
      render_422 _("Invalid submission.") if Rails.env.production?
      render_422 _("Invalid submission. Please make sure you're submitting the form using person[form_field]") unless Rails.env.production?
    end
  end

  def update
    if params.has_key?(:person)
      if !check_gender
        render_422("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}")
      else
        if @person == current_user || some_admin? || current_user.product_account
          if person_params.has_key?(:terminated) && @person.some_admin?
            return render_422 _("You cannot ban administative accounts.")
          end
          @person.update(person_params)
          if @person.terminated && @person == current_user
            logout
            cookies.delete :_fanlink_session
            return render_401 _("Your account has been banned.")
          else
            return_the @person, handler: tpl_handler, using: :show
          end
        else
          render_not_found
        end
      end
    else
      return_the @person, handler: tpl_handler, using: :show
    end
  end

  def stats
    if params.has_key?(:days) && params[:days].respond_to?(:to_i)
      time = params[:days].to_i
    else
      time = 1
    end
    @people = Person.where("created_at >= ?", time.day.ago).order(Arel.sql "DATE(created_at) ASC").group(Are.sql "Date(created_at)").count
    return_the @people, handler: tpl_handler
  end

  def send_certificate
    current_user.send_certificate_email(params[:certificate_id], params[:email_address])
    render json: { message: _("Email sent") }
  end

  protected

    def tpl_handler
      :jb
    end
end
