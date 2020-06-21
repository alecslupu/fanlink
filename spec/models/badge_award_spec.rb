# frozen_string_literal: true

RSpec.describe BadgeAward, type: :model do
  context "Valid factory" do
    it { expect(create(:badge_award)).to be_valid }
  end

  context "Associations" do
    describe "#belongs_to" do
      it { should belong_to(:badge) }
      it { should belong_to(:person).touch(true) }
    end
  end

  describe ".award_badges" do
    it "should return newly awarded badges when two earned from action" do
      badge1 = create(:badge)
      badge2 = create(:badge, product: badge1.product, action_type: badge1.action_type)
      action = BadgeAction.create(action_type: badge1.action_type, person: create(:person))
      precount = BadgeAward.count
      expect(BadgeAward.award_badges(action).sort).to eq([badge1, badge2].sort)
      expect(BadgeAward.count - precount).to eq(2)
    end
    it "should return newly awarded badges when one earned from action" do
      badge1 = create(:badge, action_requirement: 2)
      badge2 = create(:badge, product: badge1.product, action_type: badge1.action_type)
      action = BadgeAction.create(action_type: badge1.action_type, person: create(:person))
      precount = BadgeAward.count
      expect(BadgeAward.award_badges(action).sort).to eq([badge2].sort)
      expect(BadgeAward.count - precount).to eq(1)
    end
    it "should return most progress when none earned from action" do
      badge1 = create(:badge, action_requirement: 2)
      badge2 = create(:badge, product: badge1.product, action_type: badge1.action_type, action_requirement: 3)
      action = BadgeAction.create(action_type: badge1.action_type, person: create(:person))
      precount = BadgeAward.count
      expect(BadgeAward.award_badges(action)).to eq(badge1 => 1)
      expect(BadgeAward.count - precount).to eq(0)
    end
  end

  describe "#product_match" do
    it "adds error message" do
      person = create(:person)
      old_tenant = ActsAsTenant.current_tenant
      ActsAsTenant.current_tenant = create(:product)
      badge = create(:badge, action_type: create(:action_type))
      event_checkin = build(:badge_award, badge: badge, person: person)
      expect(event_checkin).not_to be_valid
      ActsAsTenant.current_tenant = old_tenant
    end
    it "passes" do
      product = create(:product)
      person = create(:person, product: product)
      badge = create(:badge, product: product, action_type: create(:action_type))
      expect(build(:badge_award, badge: badge, person: person)).to be_valid
    end
  end
end
