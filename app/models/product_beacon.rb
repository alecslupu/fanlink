class ProductBeacon < ApplicationRecord
  belongs_to :product

  acts_as_tenant(:product)

  has_paper_trail

  validates :beacon_pid, presence: { message: "Beacon PID is required." }

  normalize_attributes :attached_to, :uuid

  # default_scope { order(created_at: :desc) }
  def self.for_id_or_pid(id)
    id = id.to_s
    query = id.include?("-") ? { beacon_pid: id } : { id: id.to_i }
    ProductBeacon.find_by(query)
  end
end
