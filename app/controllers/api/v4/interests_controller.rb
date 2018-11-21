class Api::V4::InterestsController < Api::V3::InterestsController
  def index
    @interests = Interest.interests(ActsAsTenant.current_tenant).order(order: :desc)
    return_the @interests, handler: 'jb'
  end

  def create
    if current_user.some_admin?
      @interest = Interest.create(interest_params)
      if @interest.valid?
        return_the @interest, handler: 'jb', using: :show
      else
        render_422 @interest.errors
      end
    else
      render_not_found
    end
  end

  def update
    if params.has_key?(:interest)
      if current_user.some_admin?
        if @interest.update_attributes(interest_params)
          return_the @interest, handler: 'jb', using: :show
        else
          render_422 @interest.errors
        end
      else
        render_not_found
      end
    else
      return_the @interest
    end
  end
end
