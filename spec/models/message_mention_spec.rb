# frozen_string_literal: true

RSpec.describe MessageMention, type: :model do
  context 'Validation' do
    describe 'should create a valid message mention' do
      it do
        expect(build(:message_mention)).to be_valid
      end
    end
  end
end
