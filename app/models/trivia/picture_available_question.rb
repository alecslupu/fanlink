# frozen_string_literal: true

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
  class PictureAvailableQuestion < AvailableQuestion
    has_many :active_questions, class_name: 'Trivia::PictureQuestion', inverse_of: :available_question, foreign_key: :available_question_id
    has_many :available_answers, class_name: 'Trivia::PictureAvailableAnswer', foreign_key: :question_id

    include AASM
    enum status: {
      draft: 0,
      published: 1,
      locked: 2,
      closed: 3
    }

    aasm(column: :status, enum: true, whiny_transitions: false, whiny_persistence: false, logger: Rails.logger) do
      state :draft, initial: true
      state :published
      state :locked
      state :closed

      event :publish do
        # before do
        #   instance_eval do
        #     validates_presence_of :sex, :name, :surname
        #   end
        # end
        transitions from: :draft, to: :published
      end

      event :unpublish do
        transitions from: :published, to: :draft
      end

      event :locked do
        transitions from: :published, to: :locked
      end

      event :closed do
        transitions from: :locked, to: :closed
      end
    end

=begin
    validate :answer_checks

    protected
    def answer_checks
      errors.add(:base, _("You need to provide at least 2 answers")) if available_answers.count < 2
      errors.add(:base, _("You need to provide at least one correct answer")) if available_answers.where(is_correct: true).count.zero?
    end
=end
  end
end
