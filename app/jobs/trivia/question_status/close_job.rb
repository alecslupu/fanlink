# frozen_string_literal: true
module Trivia
  module QuestionStatus
    class CloseJob < ::ApplicationJob
      queue_as :trivia

      def perform(question_id)
        question = Trivia::Question.find(question_id)
        question.compute_leaderboard
      end
    end
  end
end
