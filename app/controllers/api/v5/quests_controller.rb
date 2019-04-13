class Api::V5::QuestsController < Api::V4::QuestsController
  def index
    @quests = paginate(Quest.includes(:rewards, steps: [:quest_activities]).where.not(status: :deleted).order(created_at: :desc))
    return_the @quests, handler: tpl_handler
  end

  def show
    @quest = Quest.where.not(status: :deleted).find(params[:id])
    return_the @quest
  end

  protected

    def tpl_handler
      :jb
    end
end
