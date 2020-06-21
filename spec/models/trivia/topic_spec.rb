# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trivia::Topic, type: :model do
  context 'status' do
    subject { Trivia::Topic.new }
    it { expect(subject).to respond_to(:draft?) }
    it { expect(subject).to respond_to(:published?) }
    it { expect(subject).to respond_to(:locked?) }
    it { expect(subject).to respond_to(:closed?) }
  end

  context 'State Machine' do
    subject { Trivia::Topic.new }

    it { expect(subject).to transition_from(:draft).to(:published).on_event(:publish) }
    it { expect(subject).to transition_from(:published).to(:locked).on_event(:locked)}
    it { expect(subject).to transition_from(:locked).to(:closed).on_event(:close)}
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
