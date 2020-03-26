# == Schema Information
#
# Table name: trivia_available_answers
#
#  id                 :bigint(8)        not null, primary key
#  trivia_question_id :bigint(8)
#  name               :string
#  hint               :string
#  is_correct         :boolean          default(FALSE), not null
#  status             :integer          default("draft"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#

module Trivia
  class AvailableAnswer < ApplicationRecord
    has_paper_trail
    belongs_to :question, class_name: "Trivia::AvailableQuestion", foreign_key: :trivia_question_id, optional: true

    validates :name, presence: true
    validates :hint, presence: true
    validate :changing_attributes, on: :update, if: -> { published? }
    # validate :assigned_available_question_status, on: :update

    include AASM

    enum status: {
      draft: 0,
      published: 1,
      locked: 2,
      closed: 3,
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

      event :unpublish, guards: [:available_question_status?] do
        transitions from: :published, to: :draft
      end

      event :locked do
        transitions from: :published, to: :locked
      end

      event :closed do
        transitions from: :locked, to: :closed
      end
    end

    def status_enum
      new_record? ? [:draft] : aasm.states(permitted: true).map(&:name).push(status.to_sym)
    end

    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    private

      # an answer which is assigned to a published available question
      # cannot be unpublished
      def available_question_status?
        if question.published?
          errors.add(:status, "unable to unpublish answer if assigned available question is still published")
          false
        else
          true
        end
      end

      # it's checking if an answer is being published and other attributes are also being updated
      # at the same time
      # or if just the status is being updated (publishing or unpublishing)
      # in the second condition of the OR operation it's also added that if
      # the changes size is 0, then it should not raise a validation error because
      # you can press update without actually changing anything
      def changing_attributes
        errors.add(
          :status,
          "updating attributes besides status for published answers is forbidden"
        ) if changes.size > 1 || (changes["status"].blank? && changes.size == 1)
      end
  end
end
