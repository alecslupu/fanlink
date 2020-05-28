# frozen_string_literal: true
class Api::V3::BadgesController < Api::V2::BadgesController
  before_action :admin_only, only: %i[ create update destroy ]
  load_up_the Badge, only: %i[ update show destroy ]

  # TODO: Fix nil class error when super admin attempts to get badges
  def index
    @badges = paginate(Badge.all)
    if params.has_key?(:person_id)
      @badges_awarded = PersonReward.where(person_id: params[:person_id]).joins(:reward).where("rewards.reward_type =?", Reward.reward_types["badge"])
    else
      @badges_awarded = PersonReward.where(person_id: current_user.id).joins(:reward).where("rewards.reward_type =?", Reward.reward_types["badge"])
    end
    return_the @badges
  end

  def create
    @badge = Badge.create(badge_params)
    return_the @badge
  end

  def update
    if params.has_key?(:badge)
      @badge.update(badge_params)
    end
    return_the @badge
  end

  def show
    return_the @badge
  end

  def destroy
    if some_admin?
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
