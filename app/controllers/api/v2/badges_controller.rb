class Api::V2::BadgesController < Api::V1::BadgesController
  include Wisper::Publisher
  include Rails::Pagination
  before_action :admin_only, only: %i[ create update destroy ]

  def index
    @badges = Badge.all
    if param[:person_id]
      @badges_awarded = PersonReward.where(person_id: param[:person_id], reward_type: Reward.reward_types['badge'])
    end
    return_the @badges
  end

  def create
    @badge = Badge.create(badge_params)
    if @badge.valid?
      return_the @badge
    else

    end
  end

  def update

  end

  def show

  end

  def destroy

  end

private
  def badge_params
    params.require(:badge).permit(:name, :internal_name, :status)
  end
end
