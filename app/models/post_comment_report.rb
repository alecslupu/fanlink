class PostCommentReport < ApplicationRecord
  include PostCommentReport::PortalFilters
  enum status: %i[ pending no_action_needed comment_hidden ]

  belongs_to :person
  belongs_to :post_comment

  has_paper_trail

  scope :for_product, -> (product) { joins(:person).where("people.product_id = ?", product.id) }

  validates :reason, length: { maximum: 500, message: _("Reason cannot be longer than 500 characters.") }

  normalize_attributes :reason

  def create_time
    created_at.to_s
  end

  def self.valid_status?(s)
    statuses.include?(s.to_s)
  end
end
