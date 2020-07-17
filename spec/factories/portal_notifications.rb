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

FactoryBot.define do
  factory :portal_notification do
    product { current_product }
    body { 'My Notification' }
    send_me_at { Time.zone.now.end_of_hour }
  end
end
