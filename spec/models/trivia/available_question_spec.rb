require "rails_helper"

RSpec.describe Trivia::AvailableQuestion, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_multiple_choice_available_question)).to be_valid }
    it { expect(build(:trivia_single_choice_available_question)).to be_valid }
    it { expect(build(:trivia_picture_available_question)).to be_valid }
    it { expect(build(:trivia_boolean_choice_available_question)).to be_valid }
    it { expect(build(:trivia_hangman_available_question)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belongs_to" do
        should belong_to(:topic)
      end
      it "#has_many" do
        should have_many(:available_answers)
        should have_many(:active_questions)
      end
    end
  end

  context "status" do
    subject { Trivia::AvailableQuestion.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context "State Machine" do
    subject { Trivia::AvailableQuestion.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end

  context "Validations" do
    describe "answers are not published before publishing available question" do
      before(:each) do
        available_answer = create(:trivia_available_answer, status: :draft)
        @available_question = create(:trivia_single_choice_available_question, status: :draft)
        @available_question.available_answers << available_answer
        @available_question.publish!
      end
      it "does not update status" do
        expect(@available_question.status).to eq("draft")
      end

      it "throws an error with a message" do
        expect(@available_question.errors.messages[:available_answers]).to include("used in the questions must have 'published' status before publishing")
      end
    end
  end
end
