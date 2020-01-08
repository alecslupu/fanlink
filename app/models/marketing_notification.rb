# == Schema Information
#
# Table name: marketing_notifications
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  body       :text             not null
#  person_id  :integer          not null, foreign key
#  product_id :integer          not null, foreign key
#

class MarketingNotification < ApplicationRecord
  belongs_to :person, touch: true

  acts_as_tenant(:product)

  validates :body, presence: true
  validates :title, presence: true

  after_create :notify

  private

    def notify
      Delayed::Job.enqueue(MarketingNotificationPushJob.new(id))
    end
end
