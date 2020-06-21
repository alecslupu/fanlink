# frozen_string_literal: true

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
      expect(build(:quest_completion)).to be_valid
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

    describe ".id_filter" do
      it { expect(QuestCompletion).to respond_to(:id_filter)}
      pending
    end

    describe ".person_id_filter" do
      it { expect(QuestCompletion).to respond_to(:person_id_filter)}
      pending
    end

    describe ".person_filter" do
      it { expect(QuestCompletion).to respond_to(:person_filter) }
      pending
    end

    describe ".quest_id_filter" do
      it { expect(QuestCompletion).to respond_to(:quest_id_filter) }
      pending
    end

    describe ".activity_id_filter" do
      it { expect(QuestCompletion).to respond_to(:activity_id_filter) }
      pending
    end

    describe ".activity_filter" do
      it { expect(QuestCompletion).to respond_to(:activity_filter) }
      pending
    end

  end
end
