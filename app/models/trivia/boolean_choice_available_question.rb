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
#

module Trivia
  class BooleanChoiceAvailableQuestion < AvailableQuestion
    has_many :active_questions, class_name: "Trivia::BooleanChoiceQuestion", inverse_of: :available_question, foreign_key: :available_question_id

    validate :answer_checks

    rails_admin do
      parent "Trivia::AvailableQuestion"
      label_plural "True or False"

      edit do
        exclude_fields :type
      end
    end

    protected
    def answer_checks
      errors.add(:base, _("You need to provide 2 answers")) if available_answers.count != 2
      errors.add(:base, _("You need to provide a single correct answer")) unless available_answers.where(is_correct: true).count.one?
    end
  end
end
