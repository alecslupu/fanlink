class PortalNotification < ApplicationRecord
  include PortalNotification::RealTime
  include TranslationThings

  # specify languages not used for respective fields
  IGNORE_TRANSLATION_LANGS = { body: ["un"] }

  enum sent_status: %i[ pending sent cancelled errored ]

  has_manual_translated :body

  has_paper_trail

  acts_as_tenant(:product)
  belongs_to :product

  validates :body, length: { in: 3..200, message: _("Body must be between 3 and 200 characters.") }
  validates :send_me_at, presence: { message: _("You must specify a date and time to send the notification.") }

  validate :sensible_send_time

  scope :for_product, -> (product) { where(product_id: product.id) }

  def ignore_translation_lang?(field, lang)
    IGNORE_TRANSLATION_LANGS.has_key?(field) && IGNORE_TRANSLATION_LANGS[field].include?(lang)
  end

  def push_topics
    topics = {}
    LANGS.keys.each do |l|
      topics[l] = "#{product.internal_name}-portal_notices-#{l}" unless ignore_translation_lang?(:body, l)
    end
    topics
  end
private

  def sensible_send_time
    unless persisted?
      if send_me_at.present? && send_me_at < Time.now
        errors.add(:send_me_at, _("You cannot set the send time to a time before now."))
      end
    end
  end
end
