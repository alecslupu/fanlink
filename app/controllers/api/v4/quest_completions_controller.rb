# frozen_string_literal: true

module Api
  module V4
    class QuestCompletionsController < Api::V3::QuestCompletionsController
      def index
        @completions = apply_filters_for_user
        return_the @completions, handler: tpl_handler
      end

      def list
        @completions = paginate apply_filters
        return_the @completions, handler: tpl_handler
      end

      def show
        @completion = QuestCompletion.find(params[:id])
        return_the @completion, handler: tpl_handler
      end

      def create
        if !params.has_key?(:step_id)
          quest_activity = QuestActivity.find(params[:activity_id])
          step_id = quest_activity.step.id
        end

        step_id ||= params[:step_id]

        @completion = QuestCompletion.create(completion_params.merge(person_id: current_user.id, step_id: step_id))

        if @completion.valid?
          broadcast(:completion_created, current_user, @completion)
          return_the @completion, handler: tpl_handler, using: :show
        else
          render_422 @completion.errors
        end
      end

      def update
        if params.has_key?(:quest_completion)
          @completion = QuestCompletion.find(params[:id])
          if @completion.update(completion_params)
            return_the @completion, handler: tpl_handler, using: :show
          else
            render_422 @completion.errors
          end
        else
          return_the @completion, handler: tpl_handler, using: :show
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
