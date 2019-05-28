require 'rails_helper'

RSpec.describe Trivia::AvailableQuestion, type: :model do

  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should have_many(:available_answers)
      end
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
