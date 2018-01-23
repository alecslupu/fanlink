describe "Badges (v1)" do

  describe "#index" do
    it "should return pending and earned badges" do
      person = create(:person)
      action_type = create(:action_type, product: person.product)
      badge1 = create(:badge, action_type: action_type, action_requirement: 1)
      badge2 = create(:badge, action_type: action_type, action_requirement: 4)
      BadgeAward.create(badge: badge1, person: person)
      person.badge_actions.create(action_type: action_type)
      login_as(@person)
      get "/badges"
      expect(response).to be_success
    end
  end
end