require "rails_helper"

RSpec.describe Api::V4::InterestsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    pending
  end

  # TODO: auto-generated
  describe "POST create" do
    pending
  end

  # TODO: auto-generated
  describe "PUT update" do
    pending
  end

  describe "GET match" do
    it "gets all the people that have at least one of the given interests, except current user, in no of interests desc order" do
      current_user = create(:person)
      ActsAsTenant.with_tenant(current_user.product) do
        login_as(current_user)

        people = create_list(:person, 2)
        interests = create_list(:interest, 3)
        create(:person_interest, person: current_user, interest: interests.first)
        create(:person_interest, person: current_user, interest: interests.second)
        create(:person_interest, person: people.first, interest: interests.first)
        create(:person_interest, person: people.second, interest: interests.second)
        create(:person_interest, person: people.second, interest: interests.third)

        get :match, params: { interest_ids: "#{interests.first.id},#{interests.second.id}, #{interests.third.id}" }

        expect(response).to be_successful
        expect(json["matches"].map { |a_match| a_match["person"]["id"].to_i }).not_to include(current_user)
        expect(json["matches"].first["person"]["id"].to_i).to eq(people.second.id)
        expect(json["matches"].first["matched_interest_ids"].sort).to eq(interests.last(2).pluck(:id).sort)
        expect(json["matches"].second["person"]["id"].to_i).to eq(people.first.id)
        expect(json["matches"].second["matched_interest_ids"].sort).to eq([interests.first.id])
      end
    end

    it "does not return people with product accounts" do
      current_user = create(:person)
      ActsAsTenant.with_tenant(current_user.product) do
        login_as(current_user)

        product_account_person = create(:person, product_account: true)
        person2 = create(:person, product_account: false)
        interests = create_list(:interest, 3)
        create(:person_interest, person: product_account_person, interest: interests.first)
        create(:person_interest, person: person2, interest: interests.third)

        get :match, params: { interest_ids: "#{interests.first.id},#{interests.second.id}, #{interests.third.id}" }

        expect(response).to be_successful
        person_ids = json["matches"].map { |a_match| a_match["person"]["id"].to_i }
        expect(person_ids).not_to include(product_account_person.id)
        expect(person_ids).to include(person2.id)
      end
    end
  end
end
