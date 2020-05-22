# frozen_string_literal: true
# == Schema Information
#
# Table name: product_beacons
#
#  id          :bigint(8)        not null, primary key
#  product_id  :integer          not null
#  beacon_pid  :text             not null
#  attached_to :integer
#  deleted     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  uuid        :uuid
#  lower       :integer          not null
#  upper       :integer          not null
#

class ProductBeacon < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  has_paper_trail ignore: [:created_at, :updated_at]


  validates :beacon_pid, presence: { message: _("Beacon PID is required.") }

  normalize_attributes :attached_to, :uuid

  # default_scope { order(created_at: :desc) }
  def self.for_id_or_pid(id)
    where(id: id).or(where(beacon_pid: id))
  end
end
