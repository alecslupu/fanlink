require "rails_helper"

RSpec.describe Trivia::Question, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_question)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:round)
        should belong_to(:available_question)
        should have_many(:trivia_answers)
        should have_many(:leaderboards)
      end
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"

  context "complete round" do
    it "" do
      round = create :trivia_question

      expect(round.available_answers.size).to eq(4)
    end
  end

  context "scheduled round" do
    describe ".compute_gameplay_parameters" do
      it "has the method" do
        expect(Trivia::Question.new.respond_to?(:compute_gameplay_parameters)).to eq(true)
      end
      it "sets the end date" do
        time = DateTime.now.to_i
        question = create(:trivia_question, start_date: time, time_limit: 10)
        question.compute_gameplay_parameters
        expect(question.end_date).to eq(time + 10.seconds)
      end
    end

    describe ".end_date_with_cooldown" do
      it "has the method" do
        expect(Trivia::Question.new.respond_to?(:end_date_with_cooldown)).to eq(true)
      end
      it "sets the end date" do
        time = DateTime.now.to_i
        question = create(:trivia_question, start_date: time, time_limit: 10, cooldown_period: 5)
        question.compute_gameplay_parameters
        expect(question.end_date_with_cooldown).to eq(time + 15.seconds)
      end
    end

    describe ".set_order" do
      it "has the method" do
        expect(Trivia::Question.new.respond_to?(:set_order)).to eq(true)
      end
    end


  end
end
