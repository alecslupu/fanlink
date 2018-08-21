class Api::V3::BadgesController < Api::V3::BaseController
  before_action :admin_only, only: %i[ create update destroy ]
  load_up_the Badge, only: %i[ update show destroy ]

  # TODO: Fix nil class error when super admin attempts to get badges
  def index
    @badges = paginate(Badge.all)
    if current_user&.app == "portal"
      @series_total = 0
    else
      if params.has_key?(:person_id)
        @badges_awarded = PersonReward.where(person_id: params[:person_id]).joins(:reward).where("rewards.reward_type =?", Reward.reward_types["badge"])
        @series_total = Person.find(params[:person_id]).reward_progresses || 0
      else
        @badges_awarded = PersonReward.where(person_id: current_user.id).joins(:reward).where("rewards.reward_type =?", Reward.reward_types["badge"])
        @series_total = RewardProgress.find_by(person_id: current_user.id)
      end
    end
    return_the @badges
  end

  def create
    @badge = Badge.create(badge_params)
    if @badge.valid?
      
    else
      render_422 @badge.errors.messages.values.flatten
    end
  end

  def update
    if @badge.update_attributes(badge_params)
      return_the @badge
    else
      render_422 @badge.errors.messages.values.flatten
    end
  end

  def show
    return_the @badge
  end

  def destroy
    if current_user.some_admin?
      if current_user.super_admin? && param[:force] == "1"
        @badge.destroy
        head :ok
      end
    else
      render_not_found
    end
  end

private
  def badge_params
    params.require(:badge).permit(:name, :internal_name, :description, :picture, :action_type_id, :issued_from, :issued_to)
  end

  def sa_badge_params
    params.require(:badge).permit(:name, :internal_name, :description, :picture, :action_type_id, :issued_from, :issued_to)
  end
end
