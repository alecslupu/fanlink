# frozen_string_literal: true

require "rails_helper"

RSpec.describe Trivia::SingleChoiceQuestion, type: :model do
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#belong_to" do
        should belong_to(:available_question)
      end
    end

    describe "copy_to_new" do
      it "has the method" do
        expect(Trivia::SingleChoiceQuestion.new.respond_to?(:copy_to_new)).to eq(true)
      end
      context "creates new record" do
        before do
          create(:trivia_single_choice_question)
          expect(Trivia::SingleChoiceQuestion.count).to eq(11)
          @old_round = Trivia::SingleChoiceQuestion.last
          @round_object = @old_round.copy_to_new
          expect(Trivia::SingleChoiceQuestion.count).to eq(12)
        end

        it { expect(@round_object).to be_a(Trivia::SingleChoiceQuestion) }
        it { expect(@round_object.start_date).to eq(nil) }
        it { expect(@round_object.end_date).to eq(nil) }
      end
    end
  end
end
