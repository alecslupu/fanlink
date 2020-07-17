# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_prizes
#
#  id                 :bigint           not null, primary key
#  trivia_game_id     :bigint
#  status             :integer          default("draft"), not null
#  description        :text
#  position           :integer          default(1), not null
#  photo_file_name    :string
#  photo_file_size    :integer
#  photo_content_type :string
#  photo_updated_at   :string
#  is_delivered       :boolean          default(FALSE)
#  prize_type         :integer          default("digital")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#

module Trivia
  class Prize < ApplicationRecord
    include AttachmentSupport
    acts_as_tenant(:product)
    scope :for_product, ->(product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :game, class_name: 'Trivia::Game', foreign_key: :trivia_game_id

    has_image_called :photo

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

    def copy_to_new
      new_entry = dup
      new_entry.update!(status: :draft)
      new_entry
    end

    def status_enum
      new_record? ? [:draft] : aasm.states(permitted: true).map(&:name).push(status)
    end

    enum prize_type: %i[digital physical]

    def game_id
      trivia_game_id
    end

    scope :visible, -> { where(status: [:published, :locked]) }
  end
end
