# == Schema Information
#
# Table name: automated_notifications
#
#  id                :bigint(8)        not null, primary key
#  title             :string           not null
#  body              :text             not null
#  person_id         :integer          not null, foreign key
#  criteria          :integer          not null
#  enabled           :boolean          not null
#  product_id        :integer          not null, foreign key
#  last_sent_at      :datetime
#

class AutomatedNotification < ApplicationRecord
  belongs_to :person, touch: true
  belongs_to :product

  acts_as_tenant(:product)

  enum criteria: {
    inactive_48h: 0,
    inactive_7days: 1,
    inactive_30days: 2,
    active_48h: 3,
    active_7days: 4,
    active_30days: 5
  }

  validates :body, presence: true
  validates :title, presence: true
  validates :criteria, presence: true
  validates :product_id, presence: true
  validates :person_id, presence: true
  validates :ttl_hours, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
