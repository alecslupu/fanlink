# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trivia::PictureQuestion, type: :model do
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#belong_to' do
        should belong_to(:available_question)
      end
    end


    describe 'copy_to_new' do
      it 'has the method' do
        expect(Trivia::PictureQuestion.new.respond_to?(:copy_to_new)).to eq(true)
      end
      context 'creates new record' do
        before do
          create(:trivia_picture_question)
          expect(Trivia::PictureQuestion.count).to eq(1)
          @old_round = Trivia::PictureQuestion.last
          @round_object = @old_round.copy_to_new
          expect(Trivia::PictureQuestion.count).to eq(2)
        end

        it { expect(@round_object).to be_a(Trivia::PictureQuestion) }
        it { expect(@round_object.start_date).to eq(nil) }
        it { expect(@round_object.end_date).to eq(nil) }
      end
    end
  end
end
