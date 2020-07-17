# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id                   :bigint           not null, primary key
#  person_id            :integer          not null
#  room_id              :integer          not null
#  body                 :text
#  hidden               :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default("pending"), not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  audio_file_name      :string
#  audio_content_type   :string
#  audio_file_size      :integer
#  audio_updated_at     :datetime
#

require 'faker'

FactoryBot.define do
  factory :message do
    person { create(:person) }
    room { create(:room) }
    body { Faker::Lorem.paragraph }
  end
end
