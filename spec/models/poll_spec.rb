# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Poll, type: :model do
  # TODO: auto-generated
  describe '#closed?' do
    pending
  end

  # TODO: auto-generated
  describe '#start_date_cannot_be_in_the_past' do
    pending
  end

  # TODO: auto-generated
  describe '#description_cannot_be_empty' do
    pending
  end

  # TODO: auto-generated
  describe '#was_voted' do
    pending
  end

  context 'Valid factory' do
    it { expect(build(:poll)).to be_valid }
  end

  context 'Validations' do
    subject { described_class.new(start_date: DateTime.now + 1.day, end_date: DateTime.now + 2.day) }

    describe 'uniqueness of poll_type and poll_type_id' do
      it 'returns an error when poll_type and poll_type_id pair is not unique' do
        poll = create(:poll)
        subject.poll_type = poll.poll_type
        subject.poll_type_id = poll.poll_type_id
        subject.valid?
        expect(subject.errors[:poll_type_id].first).to include('has already been used on that Post')
      end
    end

    describe '#description_cannot_be_empty' do
      it 'returns an error when description is empty' do
        subject.description = ''
        subject.valid?
        expect(subject.errors[:description_error].first).to include("description can't be empty")
      end
    end

    describe '#start_date_cannot_be_in_the_past' do
      it 'returns an error when start date is in the past' do
        subject.start_date = DateTime.now - 1.hour
        subject.valid?
        expect(subject.errors[:expiration_date].first).to include("poll can't start in the past")
      end
    end

    describe '#duration' do
      it 'should be invalid when equal to 0' do
        subject.end_date = subject.start_date # to make duration 0, can't be done directly
        subject.valid?
        message = 'Duration cannot be 0, please specify duration or end date of the poll'
        expect(subject.errors[:duration].first).to include(message)
      end

      it 'should be invalid when negative' do
        subject.duration = rand(100) * (-1)
        subject.valid?
        message = 'Duration cannot be 0, please specify duration or end date of the poll'
        expect(subject.errors[:duration].first).to include(message)
      end
    end
  end
end
