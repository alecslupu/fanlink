RSpec.describe QuestCompletion, type: :model do
  context "Associations" do
    describe "it should validation associatations for" do
      it "#belongs_to" do
        should belong_to(:step).touch(true)
        should belong_to(:person).touch(true)
        should belong_to(:quest_activity).with_foreign_key("activity_id")
      end
    end
  end

  context "Validation" do
    it "should create a valid quest completion" do
      expect(create(:quest_completion)).to be_valid
    end
  end

  context "Enumeration" do
    it "#should define status enumerables with values of locked, unlocked, and disabled" do
      should define_enum_for(:status).with([:locked, :unlocked, :completed])
    end
  end

  context "Scopes" do
    it "should return a count of activities associated with a step" do
      qc = create(:quest_completion)
      expect(QuestCompletion.count_activity(qc.step_id)).to eq(1)
    end
  end
end
