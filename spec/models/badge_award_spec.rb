RSpec.describe BadgeAward, type: :model do

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

  describe "product match" do
    it "should not let you award a badge from the wrong product" do
      product = create(:product)
      person = create(:person)
      badge = create(:badge, product: product, action_type: create(:action_type))
      ba = BadgeAward.new(person_id: person.id, badge_id: badge.id)
      expect(ba).not_to be_valid
    end
  end
end
