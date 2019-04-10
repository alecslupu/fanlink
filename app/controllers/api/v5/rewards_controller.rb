class Api::V5::RewardsController < Api::V4::RewardsController
  def index
    @rewards = paginate(Reward.all.order(created_at: :asc))
    return_the @rewards, handler: tpl_handler
  end

  def show
    return_the @reward, handler: tpl_handler
  end
end
