# frozen_string_literal: true

# == Schema Information
#
# Table name: quests
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  event_id             :integer
#  name_text_old        :text
#  internal_name        :text             not null
#  description_text_old :text
#  status               :integer          default("active"), not null
#  starts_at            :datetime         not null
#  ends_at              :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  picture_meta         :text
#  name                 :jsonb            not null
#  description          :jsonb            not null
#  reward_id            :integer
#

require "faker"

FactoryBot.define do
  factory :quest do
    product { current_product }
    name { "Quest 1" }
    internal_name { "quest_1" }
    description { Faker::Lorem.paragraph }
    starts_at { Time.zone.now }
  end
end
