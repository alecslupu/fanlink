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
#  date              :datetime         not null, default: current timestamp
#  timezone          :integer          not null, default: 0
#  product_id        :integer          not null, foreign key
#

class MarketingNotification < ApplicationRecord
  acts_as_tenant(:product)

  belongs_to :person

  enum person_filter: {
    send_to_all: 0,
    has_free_certificates_enrolled: 1,
    has_no_free_certificates_enrolled: 2,
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
    has_no_sent_messages: 17,
    active_48h: 18,
    active_7days: 19,
    active_30days: 20
  }

  enum timezone: {
    "UTC -12:00": 0,
    "UTC -11:00": 1,
    "UTC -10:00": 2,
    "UTC -09:30": 3,
    "UTC -09:00": 4,
    "UTC -08:00": 5,
    "UTC -07:00": 6,
    "UTC -06:00": 7,
    "UTC -05:00": 8,
    "UTC -04:00": 9,
    "UTC -03:30": 10,
    "UTC -03:00": 11,
    "UTC -02:00": 12,
    "UTC -01:00": 13,
    "UTC ": 14,
    "UTC +01:00": 15,
    "UTC +02:00": 16,
    "UTC +03:00": 17,
    "UTC +03:30": 18,
    "UTC +04:00": 19,
    "UTC +04:30": 20,
    "UTC +05:00": 21,
    "UTC +05:30": 22,
    "UTC +05:45": 23,
    "UTC +06:00": 24,
    "UTC +06:30": 25,
    "UTC +07:00": 26,
    "UTC +08:00": 27,
    "UTC +08:45": 28,
    "UTC +09:00": 29,
    "UTC +09:30": 30,
    "UTC +10:00": 31,
    "UTC +10:30": 32,
    "UTC +11:00": 33,
    "UTC +12:00": 34,
    "UTC +12:45": 35,
    "UTC +13:00": 36,
    "UTC +14:00": 37

  }

  validates :body, presence: true
  validates :title, presence: true
  validates :ttl_hours, presence: true, numericality: { greater_than_or_equal_to: 0,  less_than_or_equal_to: 672 }
  validates :person_filter, presence: true
  validates :date, presence: true
  validates :timezone, presence: true

  before_validation :set_person_id
  after_save :enqueue_delayed_job

  private
    def set_person_id
      if Person.current_user.product_id == ActsAsTenant.current_tenant.id
        self.person_id = Person.current_user.id
      else
        self.person_id = ActsAsTenant.current_tenant.people.where(product_account: true).first.id
      end
    end

    def enqueue_delayed_job
      date = self.date.asctime.in_time_zone("UTC")
      timezone = self.timezone
      case timezone[4]
      when "-"
        run_at = date + timezone[5..6].to_i.hour + timezone[8..9].to_i.minute
      when "+"
        run_at = date - timezone[5..6].to_i.hour - timezone[8..9].to_i.minute
      end
      delete_existing_delayed_job
      Delayed::Job.enqueue(MarketingNotificationPushJob.new(id), run_at: run_at)
    end

    def delete_existing_delayed_job
      delayed_job = Delayed::Job.where("handler LIKE '%notification_id: #{self.id}\n%'").first

      delayed_job.destroy if delayed_job
    end
end
