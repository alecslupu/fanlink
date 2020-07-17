# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_prizes
#
#  id                 :bigint           not null, primary key
#  trivia_game_id     :bigint
#  status             :integer          default("draft"), not null
#  description        :text
#  position           :integer          default(1), not null
#  photo_file_name    :string
#  photo_file_size    :integer
#  photo_content_type :string
#  photo_updated_at   :string
#  is_delivered       :boolean          default(FALSE)
#  prize_type         :integer          default("digital")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#


require 'rails_helper'

RSpec.describe Trivia::Prize, type: :model do
  context 'Valid factory' do
    it { expect(build(:trivia_prize)).to be_valid }
  end
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#belongs_to' do
        should belong_to(:game)
      end
    end
  end

  describe '.game_id' do
    it 'matches the trivia game id' do
      prize = create :trivia_prize
      expect(prize.game_id).to eq(prize.trivia_game_id)
    end
  end

  describe '.product' do
    it 'matches the game product' do
      prize = create :trivia_prize
      expect(prize.product).to eq(prize.game.product)
    end
  end

  context 'status' do
    subject { Trivia::Prize.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context 'State Machine' do
    subject { Trivia::Prize.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end

  describe 'copy_to_new' do
    it { expect(Trivia::Prize.new.respond_to?(:copy_to_new)).to eq(true) }
    context 'creates new record' do
      before do
        create(:trivia_prize)
        expect(Trivia::Prize.count).to eq(1)
        @old_prize = Trivia::Prize.last
        @prize_object = @old_prize.copy_to_new
        expect(Trivia::Prize.count).to eq(2)
      end

      it { expect(@prize_object).to be_a(Trivia::Prize) }
      it { expect(@prize_object.status).to eq('draft') }
    end
  end
end
