require "rails_helper"

RSpec.describe Trivia::AvailableAnswer, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_available_answer)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:question)
      end
    end
  end

  context "status" do
    subject { Trivia::AvailableAnswer.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context "State Machine" do
    subject { Trivia::AvailableAnswer.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end

  context "#validations" do
    describe "#name" do
      it { should validate_presence_of(:name) }
    end

    describe "#hint" do
      it { should validate_presence_of(:hint) }
    end
  end

  context "#changing_attribute" do
    describe "when publishing an available answer while also changing other attributes" do
      before(:all) do
        @available_answer = create(:trivia_available_answer)
        @name = @available_answer.name

        @available_answer.update(status: :published, name: "another name")
        @available_answer.reload
      end

      it "does not update the status" do
        expect(@available_answer.status).to eq("draft")
      end

      it "does not update other attributes" do
        expect(@available_answer.name).to eq(@name)
      end

      it "throws an error with message" do
        expect(@available_answer.errors[:status]).to include("is the only attribute that can be changed when the answer is published on being published")
      end
    end

    describe "when changing attributes for an published answer" do
      before(:all) do
        @available_answer = create(:trivia_available_answer)
        @name = @available_answer.name
        @available_answer.update(status: :published)
        @available_answer.update(name: "another name")
        @available_answer.reload
      end

      it "updates the status" do
        expect(@available_answer.status).to eq("published")
      end

      it "does not update the attributes" do
        expect(@available_answer.name).to eq(@name)
      end

      it "throws an error with message" do
        expect(@available_answer.errors[:status]).to include("is the only attribute that can be changed when the answer is published on being published")
      end
    end

    describe "when changing only the status for a draft answer" do
      before(:all) do
        @available_answer = create(:trivia_available_answer)
        @available_answer.update(status: :published)
      end

      it "updates the status" do
        expect(@available_answer.reload.status).to eq("published")
      end
    end

    describe "when changing only the status for a published answer" do
      before(:all) do
        @available_answer = create(:trivia_available_answer)
        @available_answer.update(status: :published)
        @available_answer.update(status: :draft)
      end

      it "updates the status" do
        expect(@available_answer.reload.status).to eq("draft")
      end
    end
  end
end
