# frozen_string_literal: true
class Api::V4::InterestsController < Api::V3::InterestsController
  def index
    @interests = Interest.interests(ActsAsTenant.current_tenant).order(order: :desc)
    return_the @interests, handler: tpl_handler
  end

  def create
    if some_admin?
      @interest = Interest.create(interest_params)
      if @interest.valid?
        return_the @interest, handler: tpl_handler, using: :show
      else
        render_422 @interest.errors
      end
    else
      render_not_found
    end
  end

  def update
    if params.has_key?(:interest)
      if some_admin?
        if @interest.update(interest_params)
          return_the @interest, handler: tpl_handler, using: :show
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

  def match
    if params.has_key?(:interest_ids)
      interest_ids = params[:interest_ids].split(",").map(&:to_i)
      if interest_ids.length.between? 3, 5
        # @people = paginate PersonInterest.match(interest_ids.map(&:to_i), current_user.id)
        @people = paginate Person.with_matched_interests(interest_ids, current_user.id)
        return_the @people, handler: tpl_handler
      else
        render_422 _("Please select between 3 and 5 interests.")
      end
    else
      render_404
    end
  end

  protected

  def tpl_handler
    "jb"
  end
end
