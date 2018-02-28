describe "BadgeActions (v1)" do
  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new action and return partially earned badge with highest percent earned" do
      login_as(@person)
      action_type = create(:action_type)
      badge1 = create(:badge, action_type: action_type, action_requirement: 3)
      badge2 = create(:badge, action_type: action_type, action_requirement: 4)
      badge_other = create(:badge)
      login_as(@person)
      post "/badge_actions", params: { badge_action: { action_type: action_type.internal_name } }
      expect(response).to be_success
      expect(json["pending_badge"]).to eq(pending_badge_json(1, badge1))
    end
    it "should create a new action and return single earned badge" do
      login_as(@person)
      action_type = create(:action_type)
      badge1 = create(:badge, action_type: action_type, action_requirement: 1)
      badge2 = create(:badge, action_type: action_type, action_requirement: 4)
      badge_other = create(:badge)
      login_as(@person)
      post "/badge_actions", params: { badge_action: { action_type: action_type.internal_name } }
      expect(response).to be_success
      expect(json["badges_awarded"].count).to eq(1)
      expect(json["badges_awarded"].first).to eq(badge_json(badge1))
    end
    it "should create a new action and return multiple earned badges" do
      login_as(@person)
      action_type = create(:action_type)
      badge1 = create(:badge, action_type: action_type, action_requirement: 1)
      badge2 = create(:badge, action_type: action_type, action_requirement: 1)
      badge_other = create(:badge)
      login_as(@person)
      post "/badge_actions", params: { badge_action: { action_type: action_type.internal_name } }
      expect(response).to be_success
      expect(json["badges_awarded"].count).to eq(2)
      expect(json["badges_awarded"].first).to eq(badge_json(badge1))
      expect(json["badges_awarded"].last).to eq(badge_json(badge2))
    end
    it "should create a new action and return nil if everything already earned" do
      login_as(@person)
      action_type = create(:action_type)
      badge1 = create(:badge, action_type: action_type, action_requirement: 1)
      BadgeAward.create(person: @person, badge: badge1)
      login_as(@person)
      post "/badge_actions", params: { badge_action: { action_type: action_type.internal_name } }
      expect(response).to be_success
      expect(json.keys).to include("pending_badge")
      expect(json["pending_badge"]).to be_nil
    end
    it "should not create an action if not enough time has passed since last one of this type" do
      person = create(:person)
      action_type = create(:action_type, seconds_lag: 120)
      person.badge_actions.create(action_type: action_type)
      login_as(person)
      post "/badge_actions", params: { badge_action: { action_type: action_type.internal_name } }
      expect(response.code).to eq("429")
    end
    it "should create an action if enough time has passed since last one of this type" do
      person = create(:person)
      action_type = create(:action_type, seconds_lag: 120)
      person.badge_actions.create(action_type: action_type)
      Timecop.travel(Time.zone.now + 121.seconds) do
        login_as(person)
        post "/badge_actions", params: { badge_action: { action_type: action_type.internal_name } }
        expect(response).to be_success
      end
    end
    it "should not create an action with dup person, action and identifier" do
      person = create(:person)
      action_type = create(:action_type)
      ident = "myident"
      person.badge_actions.create(action_type: action_type, identifier: ident)
      login_as(person)
      post "/badge_actions", params: { badge_action: { action_type: action_type.internal_name, identifier: ident } }
      expect(response).to be_unprocessable
      expect(json["errors"].first).to include("cannot get credit for that action")
    end
    it "should not create action if missing badge action" do
      person = create(:person)
      login_as(person)
      post "/badge_actions", params: {}
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("You must supply a badge action type")
    end
    it "should not create action if missing action type" do
      person = create(:person)
      login_as(person)
      post "/badge_actions", params: { badge_action: { identifier: "fdafdf" } }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("You must supply a badge action type")
    end
  end
end
