require 'rails_helper'

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

  pending "add some examples to (or delete) #{__FILE__}"
end
