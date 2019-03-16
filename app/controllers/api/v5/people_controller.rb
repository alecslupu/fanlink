class Api::V5::PeopleController < Api::V4::PeopleController
  def index
    @people = paginate apply_filters
    @people = @people.reject {|person| person==current_user}
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

  def list
    @people = Person.all
    return_the @people, handler: tpl_handler
  end
end
