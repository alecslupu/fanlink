# frozen_string_literal: true

FactoryBot.define do
  factory :client_to_person, class: 'Courseware::Client::ClientToPerson' do
    person { create(:person) }
    client { create(:person) }
    status { :active }

    type { 'Courseware::Client::ClientToPerson' }
  end
end
