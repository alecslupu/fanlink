# frozen_string_literal: true

module Trivia
  module RoundStatus
    class RunningJob < ::ApplicationJob
      queue_as :trivia

      def perform(round_id)
        round = Trivia::Round.find(round_id)
        round.running!

        round.reload.questions.each do |question|
          ::Trivia::QuestionStatus::CloseJob.set(wait_until: Time.at(question.end_date) + 1.second).perform_later(question.id)
        end
      end

    end
  end
end
