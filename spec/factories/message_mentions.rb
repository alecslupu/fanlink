FactoryBot.define do
  factory :message_mention do
    message { create(:message) }
    person { create(:person) }
  end
end
