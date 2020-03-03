module Trivia
  module RoundStatus
    class RunningJob < Struct.new(:round_id)

      def perform
        round = Trivia::Round.find(round_id)
        round.running!

        round.reload.questions.each do |question|
          Delayed::Job.enqueue(::Trivia::QuestionStatus::CloseJob.new(question.id), run_at: Time.at(question.end_date) + 1.second)
        end
      end
    end
  end
end
