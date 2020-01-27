class Api::V4::Referral::ReferralController < ApiController

  def index
    @people = paginate(current_user.referred_people)
    render :index, handler: :jb
  end

  def purchased
    @people = paginate(current_user.referred_people.joins(:certificates).where(certificates: {is_free: false}))
    render :index, handler: :jb
  end
end
