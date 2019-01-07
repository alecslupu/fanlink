class Api::V5::RewardsController < Api::V4::RewardsController
  def index
    @rewards = paginate(Reward.all.order(created_at: :asc))
    return_the @rewards, handler: 'jb'
  end

  def show
    return_the @reward, handler: 'jb'
  end
end
