class Api::V5::InterestsController < Api::V4::InterestsController
  def shared
    if params.has_key?(:interest_ids)
      interest_ids = params[:interest_ids].split(',')
      if interest_ids.length.between? 3, 5
        @people = Person.joins(:interests).where(interests: { id: interest_ids })
        return_the @people, handler: "jb"
      else
        render_422 _("Please select between 3 and 5 interests.")
      end
    else
      render_404
    end
  end
end
