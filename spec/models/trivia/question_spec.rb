# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trivia::Question, type: :model do
  context 'Valid factory' do
    it { expect(build(:trivia_single_choice_question)).to be_valid }
    it { expect(build(:trivia_multiple_choice_question)).to be_valid }
    it { expect(build(:trivia_picture_question)).to be_valid }
    it { expect(build(:trivia_boolean_choice_question)).to be_valid }
    it { expect(build(:trivia_hangman_question)).to be_valid }
  end
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#has_many' do
        should belong_to(:round)
        should belong_to(:available_question)
        should have_many(:trivia_answers)
        should have_many(:leaderboards)
      end
    end
  end

  describe '.round_id' do
    it 'matches the trivia round id' do
      round = create :trivia_single_choice_question
      expect(round.round_id).to eq(round.trivia_round_id)
    end
  end

  context 'complete round' do
    it '' do
      round = create :trivia_single_choice_question
      expect(round.available_answers.size).to eq(4)
    end
  end

  context 'scheduled round' do
    describe '.compute_gameplay_parameters' do
      it 'has the method' do
        expect(Trivia::Question.new.respond_to?(:compute_gameplay_parameters)).to eq(true)
      end
      it 'sets the end date' do
        time = (DateTime.now + 1.day).to_i
        question = create(:trivia_single_choice_question, start_date: time, time_limit: 10)
        question.compute_gameplay_parameters
        expect(question.end_date).to eq(time + 10.seconds)
      end
    end

    describe '.end_date_with_cooldown' do
      it 'has the method' do
        expect(Trivia::Question.new.respond_to?(:end_date_with_cooldown)).to eq(true)
      end

      it 'sets the end date' do
        time = (DateTime.now + 1.day).to_i
        question = create(:trivia_single_choice_question, start_date: time, time_limit: 10, cooldown_period: 15)
        question.compute_gameplay_parameters
        expect(question.end_date_with_cooldown).to eq(time + 25.seconds)
      end
    end

    describe '.set_order' do
      it 'has the method' do
        expect(Trivia::Question.new.respond_to?(:set_order)).to eq(true)
      end
    end
  end

  context 'hooks' do
    describe '#add_question_type' do
      describe 'when a question is created' do
        before(:each) do
          available_question = create(:trivia_single_choice_available_question)
          @question = Trivia::Question.new(
            attributes_for(:trivia_question).except(:available_question)
          )
          @question.available_question = available_question
          @question.save
        end

        it 'gets the type from the assigned available question' do
          expect(@question.type).to eq('Trivia::SingleChoiceQuestion')
        end
      end
    end
  end
end
