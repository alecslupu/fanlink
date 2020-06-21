# frozen_string_literal: true

# == Schema Information
#
# Table name: post_reports
#
#  id         :bigint(8)        not null, primary key
#  post_id    :integer          not null
#  person_id  :integer          not null
#  reason     :text
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostReport < ApplicationRecord
  # include PostReport::PortalFilters
  scope :status_filter, -> (query) { where(status: query.to_sym) }
  # include PostReport::PortalFilters

  enum status: %i[pending no_action_needed post_hidden]

  belongs_to :post, counter_cache: true
  belongs_to :person

  has_paper_trail ignore: [:created_at, :updated_at]

  scope :for_product, -> (product) { joins([post: :person]).where("people.product_id = ?", product.id) }

  validates :reason, length: { maximum: 500, message: _("Reason cannot be longer than 500 characters.") }

  normalize_attributes :reason
  def create_time
    created_at.to_s
  end

  def self.valid_status?(s)
    statuses.include?(s.to_s)
  end

  def post_body
    post.body
  end
end
