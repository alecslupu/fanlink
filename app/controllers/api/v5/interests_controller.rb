class Api::V5::InterestsController < Api::V4::InterestsController
  def index
    @interests = Interest.interests(ActsAsTenant.current_tenant).order(order: :desc)
    return_the @interests, handler: tpl_handler
  end

  def shared
    if params.has_key?(:interest_ids)
      interest_ids = params[:interest_ids].split(",")
      if interest_ids.length.between? 3, 5
        @people = Person.joins(:interests).where(interests: {id: interest_ids})
        return_the @people, handler: tpl_handler
      else
        render_422 _("Please select between 3 and 5 interests.")
      end
    else
      render_404
    end
  end

  def match
    if params.has_key?(:interest_ids)
      interest_ids = params[:interest_ids].split(",")
      if interest_ids.length.between? 3, 5
        @people = PersonInterest.match(interest_ids.map(&:to_i), current_user.id)
        return_the @people, handler: tpl_handler
      else
        render_422 _("Please select between 3 and 5 interests.")
      end
    else
      render_404
    end
  end
end
