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
end
