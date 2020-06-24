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
  class AvailableQuestion < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, ->(product) { where(product_id: product.id) }

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

    belongs_to :topic, class_name: 'Trivia::Topic'
    has_many :available_answers, class_name: 'Trivia::AvailableAnswer', foreign_key: :trivia_question_id
    has_many :active_questions, class_name: 'Trivia::Question', inverse_of: :available_question, dependent: :destroy

    accepts_nested_attributes_for :available_answers, allow_destroy: true

    validates :time_limit, numericality: { greater_than: 0 },
                           presence: true

    validates :cooldown_period, numericality: { greater_than: 5 },
                                presence: true

    validates :complexity, numericality: { greater_than: 0 },
                           presence: true

    validates :type, inclusion: { in: %w[Trivia::SingleChoiceAvailableQuestion
                Trivia::MultipleChoiceAvailableQuestion Trivia::PictureAvailableQuestion
                Trivia::BooleanChoiceAvailableQuestion Trivia::HangmanAvailableQuestion
              ], message: '%{value} is not a valid type' }
  end
end
