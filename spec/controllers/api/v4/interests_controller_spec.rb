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
    it "gets all the people that have at least one of the given interests, except current user" do
      current_user = create(:person)
      ActsAsTenant.with_tenant(current_user.product) do
        login_as(current_user)

        people = create_list(:person, 2)
        interests = create_list(:interest, 3)
        create(:person_interest, person: current_user, interest: interests.first)
        create(:person_interest, person: current_user, interest: interests.second)
        create(:person_interest, person: people.first, interest: interests.first)
        create(:person_interest, person: people.second, interest: interests.third)

        # interest2 = create(:interest)

        get :match, params: { interest_ids: "#{interests.first.id},#{interests.second.id}, #{interests.third.id}" }
        binding.pry
      end
    end
  end
end

    # it "should not change the current users password if it matches the current one" do
    #   password = "password"
    #   person = create(:person, password: password)
    #   ActsAsTenant.with_tenant(person.product) do
    #     login_as(person)
    #     patch :change_password,  params: { id: person.id, person: { current_password: password, new_password: password } }
    #     expect(response).to be_unprocessable
    #     expect(json["errors"]).to include("New password can't be identical to your current one")
    #   end
    # end
