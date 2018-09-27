RSpec.describe Step, type: :model do
  context "Associations" do
    describe "#should belong to" do
      it do
        should belong_to(:quest).touch(true)
      end
    end

    describe "#should have one" do
      it do
        person = create(:person)
        # should have_one(:step_completed).class_name("StepCompleted").conditions(person_id: person.id)
      end
    end

    describe "#should have many" do
      it do
        person = create(:person)
        should have_many(:quest_activities).order(created_at: :desc)
        # should have_many(:quest_completions).class_name("QuestCompletion").conditions(person_id: person.id)
        # should have_many(:assigned_rewards).with_primary_key("uuid").with_foreign_key("step_id") #Shoulda Matchers currently doesn't support the as call
        should have_many(:rewards).through(:assigned_rewards)
        should have_many(:step_unlocks).with_primary_key("uuid").with_foreign_key("step_id")
      end
    end
  end
  context "Enumeration" do
    describe "#should define initial_status enumerables with values of locked and unlocked" do
      it do
        should define_enum_for(:initial_status).with([:locked, :unlocked])
      end
    end
  end
  describe "#valid?" do
    it "should create a valid step" do
      expect(create(:step)).to be_valid
    end
  end
end
