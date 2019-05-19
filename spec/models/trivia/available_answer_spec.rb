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
  pending "add some examples to (or delete) #{__FILE__}"
end
