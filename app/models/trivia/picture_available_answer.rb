# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_picture_available_answers
#
#  id                   :bigint(8)        not null, primary key
#  question_id          :bigint(8)
#  is_correct           :boolean          default(FALSE), not null
#  status               :integer          default("draft"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  product_id           :integer          not null
#

module Trivia
  class PictureAvailableAnswer < ApplicationRecord

    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :question, class_name: 'Trivia::PictureAvailableQuestion', foreign_key: :question_id, optional: true

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

    def status_enum
      new_record? ? [:draft] : aasm.states(permitted: true).map(&:name).push(status)
    end

    has_one_attached :picture

    validates :picture, size: {less_than: 5.megabytes},
              content_type: {in: %w[image/jpeg image/gif image/png]}

    def picture_url
      picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.key].join('/') : nil
    end

    def picture_optimal_url
      opts = { resize: '1000', auto_orient: true, quality: 75}
      picture.attached? ? [Rails.application.secrets.cloudfront_url, picture.variant(opts).processed.key].join('/') : nil
    end

  end
end
