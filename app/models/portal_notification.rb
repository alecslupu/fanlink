class PortalNotification < ApplicationRecord
  include PortalNotification::RealTime
  include TranslationThings

  enum sent_status: %i[ pending sent cancelled errored ]

  has_manual_translated :body

  has_paper_trail

  acts_as_tenant(:product)

  belongs_to :person

  validates :body, length: { in: 3..200 }
  validates :send_me_at, presence: true

  validate :sensible_send_time

  scope :for_product, -> (product) { where(product_id: product.id) }

  private

  def sensible_send_time
    unless persisted?
      if send_me_at.present? && send_me_at < Time.now
        errors.add(:send_me_at, "cannot be before now.")
      end
    end
  end
end
