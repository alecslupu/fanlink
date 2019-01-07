class Api::V5::StepsController < Api::V4::StepsController
  def index
    @steps = @quest.steps.order(created_at: :asc)
    return_the @steps
  end

  def show
    @step = Step.find(params[:id])
    return_the @step
  end
end
