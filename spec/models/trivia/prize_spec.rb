require 'rails_helper'

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

  pending "add some examples to (or delete) #{__FILE__}"
end
