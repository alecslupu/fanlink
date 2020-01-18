class Api::V4::Referal::ReferalController < ApiController

  def index
    @people = paginate(current_user.refered_people)
    render :index, handler: :jb
  end

  def purchased
    @people = paginate(current_user.refered_people.joins(:certificates).where(certificates: {is_free: false}))
    render :index, handler: :jb
  end
end
