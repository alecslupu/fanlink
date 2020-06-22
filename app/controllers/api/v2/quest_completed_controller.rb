# frozen_string_literal: true

module Api
  module V2
    class QuestCompletedController < ApiController
      def index
        @quests_complete = QuestCompleted.where(person_id: current_user.id)
        return_the @quests_completed
      end

      def show
        @quest_complete = QuestCompleted.find(params[:id])
      end

      private
    end
  end
end
