class Api::V4::Referral::ReferralController < ApiController

  def index
    @people = current_user.referred_people.order(created_at: :desc, id: :desc)
    render :index, handler: :jb
  end

  def purchased
    @people = current_user.referred_people.joins(:certificates).where(certificates: {is_free: false}).order(created_at: :desc, id: :desc)
    render :index, handler: :jb
  end
end
