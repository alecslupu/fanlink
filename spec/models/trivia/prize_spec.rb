require "rails_helper"

RSpec.describe Trivia::Prize, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_prize)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belongs_to" do
        should belong_to(:game)
      end
    end
  end

  describe ".game_id" do
    it "matches the trivia game id" do
      prize = create :trivia_prize
      expect(prize.game_id).to eq(prize.trivia_game_id)
    end
  end

  describe ".product" do
    it "matches the game product" do
      prize = create :trivia_prize
      expect(prize.product).to eq(prize.game.product)
    end
  end
end
