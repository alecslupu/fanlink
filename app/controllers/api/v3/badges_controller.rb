class Api::V3::BadgesController < Api::V3::BaseController
  include Rails::Pagination
  include Wisper::Publisher
  before_action :admin_only, only: %i[ create update destroy ]
  load_up_the Badge, only: %i[ update show ]

  def index
    @badges = Badge.all
    if params.has_key?(:person_id)
      @badges_awarded = PersonReward.where(person_id: params[:person_id]).joins(:reward).where("rewards.reward_type =?", Reward.reward_types['badge'])
    end
    return_the @badges
  end

  def create
    @badge = Badge.create(badge_params)
    if @badge.valid?
      return_the @badge
    else
      render json: { errors: @badge.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    @badge.update_attributes(badge_params)
    return_the @badge
  end

  def show
    return_the @badge
  end

  def destroy

  end

private
  def badge_params
    params.require(:badge).permit(:name, :internal_name, :description, :picture, :action_type_id, :issued_from, :issued_to)
  end
end
