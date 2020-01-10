# == Schema Information
#
# Table name: marketing_notifications
#
#  id                :bigint(8)        not null, primary key
#  title             :string           not null
#  body              :text             not null
#  person_id         :integer          not null, foreign key
#  ttl_hours         :integer          not null, default: 670
#  deep_link_action  :integer          not null, default: 0
#  deep_link_value   :string
#  product_id        :integer          not null, foreign key
#

class MarketingNotification < ApplicationRecord
  belongs_to :person, touch: true

  acts_as_tenant(:product)

  enum deep_link_action: {
    send_to_all: 0,
    comments_screen: 1,
    profile_screen: 2,
    posts_screen: 3,
    feed_screen: 4,
    profile_screen: 5,
    chat_room: 6,
    comments_screen: 7,
    certificate_screen: 8
  }

  validates :body, presence: true
  validates :title, presence: true
  validates :ttl_hours, presence: true
  validates :deep_link_action, presence: true

  after_create :notify

  private

    def notify
      Delayed::Job.enqueue(MarketingNotificationPushJob.new(id))
    end
end
