class Api::V3::AssignedRewardsController < Api::V3::BaseController
  include Wisper::Publisher
  include Rails::Pagination

  def index
    @assigned = AssignedReward.all.order(created_at: :asc)
    return_the @assigned
  end

  def show
    @assigned = AssignedReward.find(params[:id])
    return_the @assigned
  end

  def create
    @assigned = AssignedReward.create(assigned_reward_params)
    if @assigned.valid?
      broadcast(:assigned_reward_created, current_user, @assigned)
      return_the @assigned
    else
      render json: { errors: @assigned.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    @assigned = AssignedReward.find(params[:id])
    if @assigned.update_attributes(assigned_reward_params)
      broadcast(:assigned_reward_updated, current_user, @assigned)
      return_the @assigned
    else
      render json: { errors: @assigned.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @assigned = AssignedReward.find(params[:id])
  end

private
  def assigned_reward_params
    params.require(:assign).permit(:reward_id, :assigned_type, :assigned_id, :max_times)
  end

  def load_assigned
    resource, id = request.path.split('/')[1,2]
    @assigned = resource.singularize.classify.constantize.find(id)
  end
end
