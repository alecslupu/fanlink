# == Schema Information
#
# Table name: trivia_available_questions
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  cooldown_period :integer
#  time_limit      :integer
#  status          :integer
#  type            :string
#  topic_id        :integer
#  complexity      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :integer          not null
#

module Trivia
  class SingleChoiceAvailableQuestion < AvailableQuestion
    has_many :active_questions, class_name: "Trivia::SingleChoiceQuestion", inverse_of: :available_question, foreign_key: :available_question_id
=begin
    validate :answer_checks

    protected
    def answer_checks
      errors.add(:base, _("You need to provide at least 2 answers")) if available_answers.count < 2
      errors.add(:base, _("You need to provide a single correct answer")) unless available_answers.select{|answer| answer.is_correct? }.count == 1
    end
=end
  end
end
