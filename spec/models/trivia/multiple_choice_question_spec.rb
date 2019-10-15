require 'rails_helper'

RSpec.describe Trivia::MultipleChoiceQuestion, type: :model do

  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belong_to" do
        should belong_to(:available_question)
      end
    end
  end
end
