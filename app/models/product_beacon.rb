class ProductBeacon < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  has_paper_trail

  validates :beacon_pid, presence: { message: _("Beacon PID is required.") }

  normalize_attributes :attached_to, :uuid

  # default_scope { order(created_at: :desc) }
  def self.for_id_or_pid(id)
    where(id: id).or(where( beacon_pid: id))
  end
end
