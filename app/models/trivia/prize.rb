# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_prizes
#
#  id                 :bigint(8)        not null, primary key
#  trivia_game_id     :bigint(8)
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
    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id

    has_one_attached :photo

    validates :photo, size: {less_than: 5.megabytes},
              content_type: {in: %w[image/jpeg image/gif image/png]}

    def photo_url
      photo.attached? ? [Rails.application.secrets.cloudfront_url, photo.key].join('/') : nil
    end

    def photo_optimal_url
      opts = { resize: "1000", auto_orient: true, quality: 75}
      photo.attached? ? [Rails.application.secrets.cloudfront_url, photo.variant(opts).processed.key].join('/') : nil
    end

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
