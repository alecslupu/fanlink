require 'rails_helper'

RSpec.describe Trivia::Round, type: :model do

  context "Valid factory" do
    it { expect(build(:trivia_round)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:game)
        should have_many(:questions)
        should have_many(:leaderboards)
      end
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"

  context "complete round" do
    it "" do
      round = create :trivia_round

      expect(round.questions.size).to eq(10)
    end
  end

  context "past round" do
    it "has a full leaderboard" do
      round = create :past_trivia_round
      expect(round.leaderboards.size).to eq(round.leaderboard_size)
    end
  end
end
