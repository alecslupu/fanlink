class PostReport < ApplicationRecord
  include PostReport::PortalFilters

  enum status: %i[ pending no_action_needed post_hidden ]

  belongs_to :post
  belongs_to :person

  has_paper_trail

  scope :for_product, -> (product) { joins([post: :person]).where("people.product_id = ?", product.id) }

  validates :reason, length: { maximum: 500 }

  normalize_attributes :reason
  def create_time
    created_at.to_s
  end

  def self.valid_status?(s)
    statuses.include?(s.to_s)
  end
end
