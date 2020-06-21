# frozen_string_literal: true

require "rails_helper"

RSpec.describe Trivia::AvailableAnswer, type: :model do
  context "Valid factory" do
    it { expect(build(:trivia_available_answer)).to be_valid }
  end
  context "Associations" do
    describe "should verify associations haven't changed for" do
      it "#has_many" do
        should belong_to(:question)
      end
    end
  end

  context "status" do
    subject { Trivia::AvailableAnswer.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context "State Machine" do
    subject { Trivia::AvailableAnswer.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked) }
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:closed) }
  end

  context "#validations" do
    describe "#name" do
      it { should validate_presence_of(:name) }
    end

    describe "#hint" do
      it { should validate_presence_of(:hint) }
    end
  end
end
