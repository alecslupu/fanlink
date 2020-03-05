# == Schema Information
#
# Table name: trivia_topics
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer          not null
#

module Trivia
  class Topic < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, ->(product) { where(product_id: product.id) }

    has_paper_trail
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

      event :unpublish do
        transitions from: :published, to: :draft
      end

      event :locked do
        transitions from: :published, to: :locked
      end

      event :close do
        transitions from: :locked, to: :closed
      end
    end

    def status_enum
      new_record? ? [:draft] : aasm.states(permitted: true).map(&:name).push(status)
    end

    scope :visible, -> { where(status: [:published, :locked, :closed]) }
  end
end
