# == Schema Information
#
# Table name: marketing_notifications
#
#  id                :bigint(8)        not null, primary key
#  title             :string           not null
#  body              :text             not null
#  person_id         :integer          not null, foreign key
#  ttl_hours         :integer          not null, default: 672
#  person_filter     :integer          not null
#  product_id        :integer          not null, foreign key
#

class MarketingNotification < ApplicationRecord
  belongs_to :person, touch: true

  acts_as_tenant(:product)

  enum person_filter: {
    send_to_all: 0,
    has_certificates_enrolled: 1,
    has_no_certificates_enrolled: 2,
    has_certificates_generated: 3,
    has_paid_certificates: 4,
    has_no_paid_certificates: 5,
    has_friends: 6,
    has_no_friends: 7,
    has_followings: 8,
    has_no_followings: 9,
    has_interests: 10,
    has_no_interests: 11,
    has_created_posts: 12,
    has_no_created_posts: 13,
    has_facebook_id: 14,
    account_created_past_24h: 15,
    accoount_created_past_7_days: 16,
    has_no_sent_messages: 17
  }

  validates :body, presence: true
  validates :title, presence: true
  validates :ttl_hours, presence: true, numericality: { greater_than_or_equal_to: 0,  less_than_or_equal_to: 672 }
  validates :person_filter, presence: true

  after_create :notify

  private

    def notify
      Delayed::Job.enqueue(MarketingNotificationPushJob.new(id))
    end
end
