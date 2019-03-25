FactoryBot.define do
  factory :activity_type do
    activity_id { create(:quest_activity).id }
    value { { id: 1, description: "Product Beacon" } }
    atype { "beacon" }

    factory :beacon_activity_type do
      atype { "beacon" }
    end

    factory :image_activity_type do
      atype {'image'}
    end

    factory :audio_activity_type do
      atype {'audio'}
    end

    factory :post_activity_type do
      atype {'post'}
    end

    factory :activity_code_activity_type do
      atype {'activity_code'}
    end
  end
end
