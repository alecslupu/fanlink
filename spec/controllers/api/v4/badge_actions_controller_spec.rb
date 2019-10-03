require "rails_helper"

RSpec.describe Api::V4::BadgeActionsController, type: :controller do

  describe "POST create" do
    it "return an error when the are no rewards on the badges" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        action_type = create(:action_type)
        badge1 = create(:badge, action_type: action_type, action_requirement: 3)
        badge2 = create(:badge, action_type: action_type, action_requirement: 4)
        badge_other = create(:badge)
        binding.pry
        post :create, params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to have_http_status(422)
        expect(json["errors"].first).to include(_('The are no rewards assigned for the badges on this action type'))
        # expect(pending_badge_json(json["pending_badge"], badge1)).to be_truthy
      end
    end
  end

end
