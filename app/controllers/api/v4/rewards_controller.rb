class Api::V4::RewardsController < Api::V3::RewardsController
  def index
    @rewards = paginate(Reward.all.order(created_at: :asc))
    return_the @rewards, handler: 'jb'
  end

  def show
    return_the @reward, handler: 'jb'
  end

  def create
    @reward = Reward.create(reward_params)
    if @reward.valid?
      return_the @reward, handler: 'jb', using: :show
    else
      render_422 @reward.errors
    end
  end

  def update
    if params.has_key?(:reward)
      if @reward.update_attributes(reward_params)
        return_the @reward, handler: 'jb', using: :show
      else
        render_422 @reward.errors
      end
    else
      return_the @reward, handler: 'jb', using: :show
    end
  end
end
