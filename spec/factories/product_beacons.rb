# frozen_string_literal: true

# == Schema Information
#
# Table name: product_beacons
#
#  id          :bigint           not null, primary key
#  product_id  :integer          not null
#  beacon_pid  :text             not null
#  attached_to :integer
#  deleted     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  uuid        :uuid
#  lower       :integer          not null
#  upper       :integer          not null
#

require 'securerandom'
require 'faker'

FactoryBot.define do
  factory :product_beacon do
    product { current_product }
    uuid { SecureRandom.uuid }
    beacon_pid { Faker::Device.serial }
    lower { 1 }
    upper { 2 }
  end
end
