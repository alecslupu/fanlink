# frozen_string_literal: true
class Api::V4::StepsController < Api::V3::StepsController
  # def index
  #   @steps = @quest.steps.order(created_at: :asc)
  #   return_the @steps, handler: 'jb'
  # end

  # def show
  #   @step = Step.find(params[:id])
  #   return_the @step, handler: 'jb'
  # end

  # def create
  #   @step = @quest.steps.create(step_params)
  #   if @step.valid?
  #     broadcast(:step_created, current_user, @step)
  #     return_the @step, handler: 'jb', using: :show
  #   else
  #     render_422 @step.errors
  #   end
  # end

  # def update
  #   if params.has_key?(:step)
  #     old_unlocks = @step.unlocks
  #     if @step.update_attributes(step_params)
  #       if old_unlocks != params[:step][:unlocks]
  #         broadcast(:unlocks_updated, current_user, @step)
  #       end
  #       return_the @step, handler: 'jb', using: :show
  #     else
  #       render_422 @step.errors
  #     end
  #   else
  #     return_the @step
  #   end
  # end
end
