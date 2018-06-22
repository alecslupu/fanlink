class Api::V2::RewardProgressesController < ApiController

  def create
    controller = request.fullpath.remove("/").remove("complete").singularize
    @progress = RewardProgress.find_or_initialize_by(reward_id: params[:reward_complete][:reward_id], person_id: current_user.id)
    @progress.series = @progress.reward.series || nil
    @progress.actions[controller] ||= 0
    @progress.actions[controller] += 1
    @progress.total ||= 0
    @progress.total += 1
    @progress.save
    return_the @progress
  end


private

  def reward_progress_params
    params.require(:reward_complete).permit(:reward_id)
  end
end
