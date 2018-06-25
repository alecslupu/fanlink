class Api::V2::RewardsController < ApiController
  include Wisper::Publisher
  include Rails::Pagination
  load_up_the Reward, from: :id, only: %i[ show update delete ]
    def index
      @rewards = Reward.all.order(created_at: :asc)
      return_the @rewards
    end

    def show
      return_the @reward
    end

    def create
      @reward = Reward.create(reward_params)
      if @reward.valid?
        return_the @reward
      else
        render json: { errors: @reward.errors.messages }, status: :unprocessable_entity
      end
    end

    def update
      if @reward.update_attributes(reward_params)
        return_the @reward
      else
        render json: { errors: @reward.errors.messages }, status: :unprocessable_entity
      end
    end

    def destroy
        reward = Reward.find(params[:id])
        if current_user.some_admin?
          reward.deleted!
          head :ok
        else
          render_not_found
        end
    end

private
    def reward_params
      params.require(:reward).permit(:name, :internal_name, :reward_type, :reward_type_id, :series, :completion_requirement, :points, :status)
    end
end
