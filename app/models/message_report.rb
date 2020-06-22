# frozen_string_literal: true

# == Schema Information
#
# Table name: message_reports
#
#  id         :bigint(8)        not null, primary key
#  message_id :integer          not null
#  person_id  :integer          not null
#  reason     :text
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageReport < ApplicationRecord
  # include MessageReport::PortalFilters
  scope :status_filter, ->(query) { where(status: query.to_sym) }

  # include MessageReport::PortalFilters

  enum status: %i[pending no_action_needed message_hidden]

  belongs_to :message
  belongs_to :person

  has_paper_trail ignore: [:created_at, :updated_at]

  validates :reason, length: { maximum: 500, message: _('Reason cannot be longer than 500 characters.') }
  validates_inclusion_of :status, in: MessageReport.statuses.keys, message: _('%{value} is not a valid status type.')

  normalize_attributes :reason

  scope :for_product, ->(product) { joins(message: :room).where(rooms: { product_id: product.id }) }

  def create_time
    created_at.to_s
  end

  def poster
    message.person
  end

  def reporter
    person
  end

  def self.valid_status?(s)
    statuses.include?(s.to_s)
  end
end
