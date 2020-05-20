# frozen_string_literal: true
class Api::V4::QuestsController < Api::V3::QuestsController
  # load_up_the Quest, only: %i[ update ]

  # def index
  #   if some_admin? && web_request?
  #     @quests = paginate apply_filters, handler: 'jb'
  #     return_the @quests
  #   else
  #     @quests = paginate Quest.includes(:rewards, steps: [:quest_activities]).order(created_at: :desc)
  #     if current_user.tester
  #       @quests = @quests.in_testing
  #     else
  #       @quests = @quests.active.running
  #     end
  #     return_the @quests, handler: "jb"
  #   end
  # end

  # def show
  #   @quest = Quest.find(params[:id]).includes(:rewards, steps: [:quest_activities])

  #   render_404 if (!some_admin? || !current_user.tester) && !@quest.active? && !@quest.running?

  #   return_the @quest, handler: "jb"
  # end


  # def create
  #   @quest = Quest.create(quest_params)
  #   if @quest.valid?
  #     return_the @quest, handler: 'jb', using: :show
  #   else
  #     render_422 @quest.errors
  #   end
  # end

  # def update
  #   if params.has_key?(:quest)
  #     if @quest.update(quest_params)
  #       return_the @quest, handler: 'jb', using: :show
  #     else
  #       render_422 @quest.errors
  #     end
  #   else
  #     render_422(_("Update failed. Missing quest object."))
  #   end
  # end

  # def list
  #   render json: { errors: { base: _("This endpoint has been deprecated. Use the index endpopint.") } }, status: :gone
  # end
end
