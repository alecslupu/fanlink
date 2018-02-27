class MessageReport < ApplicationRecord
  enum status: %i[ pending no_action_needed message_hidden ]

  belongs_to :message
  belongs_to :person

  has_paper_trail

  validates :reason, length: { maximum: 500 }

  scope :for_product, -> (product) { joins(message: :room).where("rooms.product_id = ?", product.id) }

  def create_time
    created_at.to_s
  end

  def poster
    message.person
  end

  def reporter
    person
  end
end
