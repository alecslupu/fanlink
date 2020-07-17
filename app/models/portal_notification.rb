# frozen_string_literal: true

# == Schema Information
#
# Table name: portal_notifications
#
#  id                :bigint           not null, primary key
#  product_id        :integer          not null
#  untranslated_body :jsonb            not null
#  send_me_at        :datetime         not null
#  sent_status       :integer          default("pending"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PortalNotification < ApplicationRecord
  LANGS = {
    'en' => 'English*',
    'es' => 'Spanish',
    'ro' => 'Romanian',
  }.freeze

  attr_accessor :trigger_admin_notification

  after_commit -> { enqueue_push }, on: :create, if: proc { |record| record.trigger_admin_notification }
  after_commit -> { enqueue_push }, on: :update, if: proc { |record|
    record.trigger_admin_notification == true && record.previous_changes.keys.include?('send_me_at')
  }

  # specify languages not used for respective fields
  IGNORE_TRANSLATION_LANGS = { body: ['un'] }

  enum sent_status: %i[pending sent cancelled errored]

  has_paper_trail
  translates :body, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  acts_as_tenant(:product)
  belongs_to :product

  validates :body, length: { in: 3..200, message: _('Body must be between 3 and 200 characters.') }
  validates :send_me_at, presence: { message: _('You must specify a date and time to send the notification.') }

  validate :sensible_send_time

  scope :for_product, ->(product) { where(portal_notifications: { product_id: product.id }) }

  def ignore_translation_lang?(field, lang)
    IGNORE_TRANSLATION_LANGS.has_key?(field) && IGNORE_TRANSLATION_LANGS[field].include?(lang)
  end

  def push_topics
    topics = {}
    LANGS.keys.each do |language|
      topics[language] = "#{product.internal_name}-portal_notices-#{language}" unless ignore_translation_lang?(:body, language)
    end
    topics
  end

  def future_send_date?
    self.send_me_at.present? && self.send_me_at > Time.zone.now
  end

  def enqueue_push
    if pending? && future_send_date?
      PortalNotificationPushJob.set(wait_until: self.send_me_at + 1.second).perform_later(self.id)
    end
  end

  private

  def sensible_send_time
    unless persisted?
      if send_me_at.present? && send_me_at < Time.zone.now
        errors.add(:send_me_at, :sensible_send_time, message: _('You cannot set the send time to a time before now.'))
      end
    end
  end
end
