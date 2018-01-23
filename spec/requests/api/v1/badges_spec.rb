describe "Badges (v1)" do

  describe "#index" do
    it "should return all badges" do
      person = create(:person)
      action_type = create(:action_type, product: person.product)
      action_type2 = create(:action_type, product: person.product)
      badge1 = create(:badge, action_type: action_type, action_requirement: 1)
      badge2 = create(:badge, action_type: action_type2, action_requirement: 4)
      BadgeAward.create(badge: badge1, person: person)
      person.badge_actions.create(action_type: action_type)
      login_as(person)
      get "/badges"
      expect(response).to be_success
      expect(json["badges"].count).to eq(2)
      fb = json["badges"].first
      expect(fb["badge_action_count"]).to eq(1)
      expect(fb["badge"]).to eq(badge_json(badge1))
      sb = json["badges"].last
      expect(sb["badge_action_count"]).to eq(0)
      expect(sb["badge"]).to eq(badge_json(badge2))
    end
  end
end
