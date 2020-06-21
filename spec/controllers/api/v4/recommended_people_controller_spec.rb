# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V4::RecommendedPeopleController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    it 'returns all the recommended people' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        person2 = create(:recommended_person)
        person3 = create(:recommended_person)
        create(:person)
        person.follow(person2)

        get :index

        expect(response).to be_successful

        expect(json["recommended_people"].count).to eq(2)
        expect(json["recommended_people"].map { |p| p["id"] }.sort).to eq([person2.id.to_s, person3.id.to_s].sort)
      end
    end
  end
end
