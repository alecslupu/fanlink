class Api::V3::RewardProgressesController < ApiController
  include Wisper::Publisher
  def create
    if params.has_key?(:reward_complete)
      controller = request.fullpath.remove("/").remove("complete").singularize
      @progress = RewardProgress.find_or_initialize_by(reward_id: params[:reward_complete][:reward_id], person_id: current_user.id)
      @progress.series = @progress.reward.series || nil
      @progress.actions[controller] ||= 0
      @progress.actions[controller] += 1
      @progress.total ||= 0
      @progress.total += 1
      if @progress.save
        broadcast(:reward_progress_created, current_user, @progress)
        return_the @progress
      else
        render json: { errors: @progress.errors.messages.flatten }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Missing reward_id parameter." }, status: :unprocessable_entity
    end
  end


private

  def reward_progress_params
    params.require(:reward_complete).permit(:reward_id)
  end
end
