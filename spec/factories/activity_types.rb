# frozen_string_literal: true
# == Schema Information
#
# Table name: activity_types
#
#  id          :bigint(8)        not null, primary key
#  activity_id :integer          not null
#  atype_old   :text
#  value       :jsonb            not null
#  deleted     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  atype       :integer          default("beacon"), not null
#

FactoryBot.define do
  factory :activity_type do
    activity_id { create(:quest_activity).id }
    value { { id: 1, description: "Product Beacon" } }
    atype { "beacon" }

    factory :beacon_activity_type do
      atype { "beacon" }
    end

    factory :image_activity_type do
      atype { "image" }
    end

    factory :audio_activity_type do
      atype { "audio" }
    end

    factory :post_activity_type do
      atype { "post" }
    end

    factory :activity_code_activity_type do
      atype { "activity_code" }
    end
  end
end
