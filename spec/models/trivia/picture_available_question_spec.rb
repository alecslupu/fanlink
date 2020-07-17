# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_available_questions
#
#  id              :bigint           not null, primary key
#  title           :string
#  cooldown_period :integer          default(6)
#  time_limit      :integer          default(30)
#  status          :integer
#  type            :string
#  topic_id        :integer
#  complexity      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :integer          not null
#


require 'rails_helper'

RSpec.describe Trivia::PictureAvailableQuestion, type: :model do
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#has_many' do
        should have_many(:active_questions)
      end
    end
  end

  context 'status' do
    subject { Trivia::PictureAvailableQuestion.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context 'State Machine' do
    subject { Trivia::PictureAvailableQuestion.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end
end
