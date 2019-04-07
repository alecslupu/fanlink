describe "Badges (v1)" do

  describe "#index" do
    # it "should return all badges for a passed in person" do
    #   person = create(:person)
    #   action_type = create(:action_type)
    #   action_type2 = create(:action_type)
    #   badge1 = create(:badge, action_type: action_type, action_requirement: 1)
    #   badge2 = create(:badge, action_type: action_type2, action_requirement: 4)
    #   BadgeAward.create(badge: badge1, person: person)
    #   person.badge_actions.create(action_type: action_type2)
    #   person2 = create(:person, product: person.product)
    #   login_as(person2)
    #   get "/badges", params: { person_id: person.id.to_s }
    #   expect(response).to be_success
    #   expect(json["badges"].count).to eq(2)
    #   fb = json["badges"].first
    #   expect(fb["badge_action_count"]).to eq(1)
    #   expect(badge_json(fb["badge"])).to be true
    #   sb = json["badges"].last
    #   expect(sb["badge_action_count"]).to eq(0)
    #   expect(badge_json(sb["badge"])).to be true
    # end
    # it "should return 404 for non-existent passed in person" do
    #   person2 = create(:person)
    #   login_as(person2)
    #   get "/badges", params: { person_id: (Person.last.id + 1).to_s }
    #   expect(response).to be_not_found
    # end
    # it "should return 404 for passed in person from another product" do
    #   person2 = create(:person)
    #   login_as(person2)
    #   person = create(:person, product: create(:product))
    #   get "/badges", params: { person_id: person.id }
    #   expect(response).to be_not_found
    # end
  end
end
