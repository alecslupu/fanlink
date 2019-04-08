class Api::V5::QuestCompletionsController < Api::V4::QuestCompletionsController
  def index
    @completions = apply_filters_for_user
    return_the @completions, handler: tpl_handler
  end

  def show
    @completion = QuestCompletion.find(params[:id])
    return_the @completion, handler: tpl_handler
  end
end
