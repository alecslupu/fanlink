require 'rails_helper'

RSpec.describe Trivia::Question, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_question)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:round)
        should have_many(:available_answers)
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
end
