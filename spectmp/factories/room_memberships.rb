FactoryBot.define do
  factory :room_membership do
    room { create(:room, public: false) }
    person { create(:person) }
  end
end
