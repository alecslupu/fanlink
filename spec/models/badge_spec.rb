require "rails_helper"

RSpec.describe Badge, type: :model do

  before(:all) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
  end

  context "Validation" do
    it { expect(create(:badge)).to be_valid }
  end

  describe "#action_count_earned_by" do
    let(:badge) { create(:badge) }
    let(:person) { create(:person) }
    it "should return 0 for person with nothing" do
      expect(badge.action_count_earned_by(create(:person))).to eq(0)
    end
    it "should return 0 for person with actions before issued_from with no issued to" do
      b = create(:badge, issued_from: Time.now + 1.day)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(badge.action_count_earned_by(person)).to eq(0)
    end
    it "should return single for person with actions after issued_from with no issued to" do
      b = create(:badge, issued_from: Time.now - 1.day)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(b.action_count_earned_by(person)).to eq(1)
    end
    it "should return multiple for person with actions after issued_from with no issued to" do
      b = create(:badge, issued_from: Time.now - 1.day)
      create(:badge_action, action_type: b.action_type, person: person)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(b.action_count_earned_by(person)).to eq(2)
    end
    it "should return single for person with actions after issued_from before  issued to" do
      b = create(:badge, issued_from: Time.now - 1.day)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(b.action_count_earned_by(person)).to eq(1)
    end
    it "should return multiple for person with actions after issued_from before issued to" do
      b = create(:badge, issued_from: Time.now - 1.day, issued_to: Time.now + 1.day)
      create(:badge_action, action_type: b.action_type, person: person)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(b.action_count_earned_by(person)).to eq(2)
    end
    it "should return 0 for person with actions after issued to with no issued from" do
      b = create(:badge, issued_to: Time.now - 1.day)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(badge.action_count_earned_by(person)).to eq(0)
    end
    it "should return 0 for person with actions after issued to with no issued from" do
      b = create(:badge, issued_to: Time.now - 1.day)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(badge.action_count_earned_by(person)).to eq(0)
    end
    it "should return 0 for person with actions after issued to with issued from" do
      b = create(:badge, issued_to: Time.now - 1.day, issued_from: Time.now - 3.days)
      create(:badge_action, action_type: b.action_type, person: person)
      expect(badge.action_count_earned_by(person)).to eq(0)
    end
  end

  describe "#action_requirement" do
    it "should not let you create a badge without an action requirement" do
      badge = build(:badge, action_requirement: nil)
      expect(badge).not_to be_valid
      expect(badge.errors[:action_requirement]).not_to be_empty
    end
    it "should not let you create a badge with an action requirement less than 1" do
      badge = build(:badge, action_requirement: 0)
      expect(badge).not_to be_valid
      expect(badge.errors[:action_requirement]).not_to be_empty
    end
  end

  describe "current?" do
    let(:current_time) { Time.now }
    it "should not be current if before issued_from with no issued_to" do
      badge = create(:badge, issued_from: current_time + 1.minute)
      expect(badge.current?).to be_falsey
    end
    it "should not be current if before issued_from with also an issued_to" do
      badge = create(:badge, issued_from: current_time + 1.minute, issued_to: current_time + 3.minutes)
      expect(badge.current?).to be_falsey
    end
    it "should not be current if after issued_to with no issued_from" do
      badge = create(:badge, issued_to: current_time - 1.minutes)
      expect(badge.current?).to be_falsey
    end
    it "should not be current if after issued_to with issued_from" do
      badge = create(:badge, issued_from: current_time - 1.minutes, issued_to: current_time - 1.second)
      expect(badge.current?).to be_falsey
    end
    it "should be current if after issued_from with no issued_to" do
      badge = create(:badge, issued_from: current_time - 1.minute)
      expect(badge.current?).to be_truthy
    end
    it "should be current if after issued_from with and before issued_to" do
      badge = create(:badge, issued_from: current_time - 1.minute, issued_to: current_time + 1.minute)
      expect(badge.current?).to be_truthy
    end
  end

  describe "#destroy" do
    it "should not let you destroy a badge that has been awarded" do
      badge = create(:badge)
      create(:badge_award, badge: badge)
      expect(badge.destroy).to be_falsey
      expect(badge).to exist_in_database
    end
  end

  describe "#internal_name" do
    it "should allow an internal name with lower case letters numbers and underscores" do
      expect(create(:badge, internal_name: "abc_d12"))
    end
    it "should not allow an internal name with spaces" do
      at = build(:badge, internal_name: "abc d12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with upper case" do
      at = build(:badge, internal_name: "Abcd12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with exclamation" do
      at = build(:badge, internal_name: "abc_d12!")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow a nil internal name" do
      at = build(:badge, internal_name: nil)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an empty internal name" do
      at = build(:badge, internal_name: "")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with less than 3 characters" do
      at = build(:badge, internal_name: "ab")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with more than 26 characters" do
      at = build(:badge, internal_name: "a" * 27)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow two badges in the same product to share internal name" do
      at1 = create(:badge)
      at2 = build(:badge, internal_name: at1.internal_name)
      expect(at2).not_to be_valid
      expect(at2.errors[:internal_name]).not_to be_empty
    end
    it "should allow two badges in different products to share internal name" do
      b1 = create(:badge)
      ActsAsTenant.with_tenant(create(:product)) do
        b2 = build(:badge, internal_name: b1.internal_name, action_type: create(:action_type))
        expect(b2).to be_valid
      end
    end
  end

  describe "#issued_to" do
    it "should not allow issued_to before issued_from" do
      badge = build(:badge, issued_to: Time.now - 1.day, issued_from: Time.now)
      expect(badge).not_to be_valid
      expect(badge.errors[:issued_to]).not_to be_empty
    end
  end

  describe "#product" do
    it "should not let you create a badge without a product" do
      ActsAsTenant.without_tenant do
        at = build(:badge, product: nil)
        expect(at).not_to be_valid
        expect(at.errors[:product]).not_to be_empty
      end
    end
  end
  describe "#valid?" do
    it "should create a valid badge" do
      expect(create(:badge)).to be_valid
    end
  end

  describe 'creation of reward' do
    it 'creates a reward when a badge is created' do
      expect{ create(:badge) }.to change { Reward.count }.by(1)
    end
  end

  describe 'the reward should have the corect info' do
    let(:badge) { create(:badge) }

    it 'has the corect internal name' do
      expect(badge.internal_name).to eq(badge.reward.internal_name)
    end
    it 'has the corect product' do
      expect(badge.product).to eq(badge.reward.product)
    end
    it 'has the corect name' do
      expect(badge.name).to eq(badge.reward.name)
    end
    it 'has the corect points' do
      expect(badge.point_value).to eq(badge.reward.points)
    end
    it 'has the corect completion requirements' do
      expect(badge.action_requirement).to eq(badge.reward.completion_requirement)
    end
    it 'has the corect badge' do
      expect(badge.id).to eq(badge.reward.reward_type_id)
    end
    it 'has the corect status' do
      expect(badge.reward.status).to eq('active')
    end
    it 'has the corect reward type' do
      expect(badge.reward.reward_type).to eq('badge')
    end
  end

  describe 'update of the badge triggers the update of the reward' do
    let(:badge) { create(:badge) }

    it "updates the name" do
      badge.update(name: badge.name + 's')

      expect(badge.reward.name).to eq(badge.name)
    end

    it "updates the internal name" do
      badge.update(name: badge.internal_name + 's')

      expect(badge.reward.internal_name).to eq(badge.internal_name)
    end

    it "updates the points" do
      badge.update(name: badge.point_value + 1)

      expect(badge.reward.points).to eq(badge.point_value)
    end

    it "updates the action requirement" do
      badge.update(action_requirement: badge.action_requirement + 1)

      expect(badge.reward.completion_requirement).to eq(badge.action_requirement)
    end
  end
end
