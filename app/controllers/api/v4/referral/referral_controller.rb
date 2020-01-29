class Api::V4::Referral::ReferralController < ApiController

  def index
    # @people = current_user.referred_people
    @people = Person.Person.order("RANDOM()").limit(10)
    render :index, handler: :jb
  end

  def purchased
    # @people = current_user.referred_people.joins(:certificates).where(certificates: {is_free: false})
    @people = Person.order("RANDOM()").limit(10)
    render :index, handler: :jb
  end
end
