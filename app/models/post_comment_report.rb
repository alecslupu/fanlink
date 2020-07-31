# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comment_reports
#
#  id              :bigint           not null, primary key
#  post_comment_id :integer          not null
#  person_id       :integer          not null
#  reason          :text
#  status          :integer          default("pending"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class PostCommentReport < ApplicationRecord
  enum status: { pending: 0, no_action_needed: 1, comment_hidden: 2 }

  belongs_to :person
  belongs_to :post_comment

  # include PostCommentReport::PortalFilters
  scope :status_filter, ->(query) { where(status: query.to_sym) }
  # include PostCommentReport::PortalFilters
  has_paper_trail

  scope :for_product, ->(product) { joins(:person).where('people.product_id = ?', product.id) }

  validates :reason, length: { maximum: 500, message: _('Reason cannot be longer than 500 characters.') }

  normalize_attributes :reason

  def create_time
    created_at.to_s
  end

  def self.valid_status?(s)
    statuses.include?(s.to_s)
  end
end
