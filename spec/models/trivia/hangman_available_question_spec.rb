# frozen_string_literal: true
require "rails_helper"

RSpec.describe Trivia::HangmanAvailableQuestion, type: :model do
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should have_many(:active_questions)
      end
    end
  end

  context "status" do
    subject { Trivia::HangmanAvailableQuestion.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context "State Machine" do
    subject { Trivia::HangmanAvailableQuestion.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end

  context "Validations" do
    describe "#hangman_answer" do
      describe "adding more than one answer" do
        before(:each) do
          # creating the avaialble question with only one correct available question
          @available_question = create(:trivia_hangman_available_question)
          @available_question.available_answers << create(:wrong_trivia_available_answer)
        end
        it "does not save the question" do
          expect(@available_question.save).to be_falsey
        end

        it "throws an error with a message" do
          @available_question.save
          expect(@available_question.errors.messages[:avalaible_answers]).to include("count must be equal to one for fill in the blank questions and that answer must be correct.")
        end
      end

      describe "adding one answer which is incorrect" do
        before(:each) do
          # creating the avaialble question with only one correct available question
          @available_question = create(:trivia_hangman_available_question)
          @available_question.available_answers.update(is_correct: false)
        end
        it "does not save the question" do
          expect(@available_question.save).to be_falsey
        end

        it "throws an error with a message" do
          @available_question.save
          expect(@available_question.errors.messages[:avalaible_answers]).to include("count must be equal to one for fill in the blank questions and that answer must be correct.")
        end
      end

      describe "adding one answer with hint size different than name" do
        before(:each) do
          # creating the avaialble question with only one correct available question
          @available_question = create(:trivia_hangman_available_question)
          @available_question.available_answers.update(name: "something", hint: "something else")
        end
        it "does not save the question" do
          expect(@available_question.save).to be_falsey
        end

        it "throws an error with a message" do
          @available_question.save
          expect(@available_question.errors.messages[:avalaible_answers]).to include("available answer's name must be the same length as the hint.")
        end
      end
    end
  end
end
