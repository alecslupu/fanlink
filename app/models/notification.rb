# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  body          :text             not null
#  person_id     :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  for_followers :boolean          default(FALSE), not null
#  product_id    :integer          not null
#

class Notification < ApplicationRecord
  def notify
    SimpleNotificationPushJob.perform_later(id)
  end
  acts_as_tenant(:product)

  has_paper_trail

  belongs_to :person
  validates :body, presence: true
end
