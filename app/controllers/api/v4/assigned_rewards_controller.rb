class Api::V4::AssignedRewardsController < Api::V3::AssignedRewardsController
  def index
    @assignees = paginate(AssignedReward.where(reward_id: params[:reward_id]).order(created_at: :asc))
    return_the @assignees, handler: tpl_handler
  end

  def show
    @assigned = AssignedReward.find(params[:id])
    return_the @assigned, handler: tpl_handler
  end

  def create
    if params[:assign][:assigned_type] == "ActionType"
      action_type = ActionType.find(params[:assign][:assigned_id])
      reward = Reward.find(params[:assign][:reward_id])
      reward.series = action_type.internal_name unless reward.series.present?
      reward.save
    end
    @assigned = AssignedReward.create(assigned_reward_params)
    if @assigned.valid?
      broadcast(:assigned_reward_created, current_user, @assigned)
      return_the @assigned, handler: tpl_handler, using: :show
    else
      render_422 @assigned.errors
    end
  end

  def update
    @assigned = AssignedReward.find(params[:id])
    if params.has_key?(:assign)
      if @assigned.update(assigned_reward_update_params)
        broadcast(:assigned_reward_updated, current_user, @assigned)
        return_the @assigned, handler: tpl_handler, using: :show
      else
        render_422 @assigned.errors
      end
    else
      render_422(_("Updated failed. Missing assign object."))
    end
  end

  protected

    def tpl_handler
      :jb
    end
end
