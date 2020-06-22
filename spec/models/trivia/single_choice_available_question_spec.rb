# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trivia::SingleChoiceAvailableQuestion, type: :model do
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#has_many' do
        should have_many(:active_questions)
      end
    end
  end

  context 'status' do
    subject { Trivia::SingleChoiceAvailableQuestion.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context 'State Machine' do
    subject { Trivia::SingleChoiceAvailableQuestion.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end

  context 'Validations' do
    describe '#number_of_correct_answers' do
      describe 'adding more than one correct answer' do
        before(:each) do
          @available_question = create(:trivia_single_choice_available_question, with_answers: false)
          @available_question.available_answers << create_list(:correct_trivia_available_answer, 2)
        end
        it 'does not save the question' do
          expect(@available_question.save).to be_falsey
        end

        it 'throws an error with a message' do
          @available_question.save
          expect(@available_question.errors.messages[:available_answers]).to include('Single choice questions must have one correct answer')
        end
      end

      describe 'adding no correct answer' do
        before(:each) do
          @available_question = create(:trivia_single_choice_available_question, with_answers: false)
          @available_question.available_answers << create_list(:wrong_trivia_available_answer, 2)
        end
        it 'does not save the question' do
          expect(@available_question.save).to be_falsey
        end

        it 'throws an error with a message' do
          @available_question.save
          expect(@available_question.errors.messages[:available_answers]).to include('Single choice questions must have one correct answer')
        end
      end
    end
  end
end
