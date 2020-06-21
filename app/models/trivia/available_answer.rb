# frozen_string_literal: true

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

    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }
  end
end
