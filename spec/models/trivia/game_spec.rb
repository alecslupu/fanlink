require 'rails_helper'

RSpec.describe Trivia::Game, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_game)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:product)
        should belong_to(:room)
        should have_many(:rounds)
        should have_many(:prizes)
        should have_many(:leaderboards)
      end
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
