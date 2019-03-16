class Api::V5::AssignedRewardsController < Api::V4::AssignedRewardsController
  def index
    @assignees = paginate(AssignedReward.where(reward_id: params[:reward_id]).order(created_at: :asc))
    return_the @assignees, handler: tpl_handler
  end

  def show
    @assigned = AssignedReward.find(params[:id])
    return_the @assigned, handler: tpl_handler
  end
end
