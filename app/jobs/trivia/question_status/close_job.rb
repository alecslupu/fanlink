module Trivia
  module QuestionStatus
    class CloseJob < Struct.new(:question_id)

      def perform
        question = Trivia::Question.find(question_id)
        question.compute_leaderboard
      end
    end
  end
end
