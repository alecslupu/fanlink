require "rails_helper"

RSpec.describe Trivia::MultipleChoiceAvailableQuestion, type: :model do
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should have_many(:active_questions)
      end
    end
  end
end
