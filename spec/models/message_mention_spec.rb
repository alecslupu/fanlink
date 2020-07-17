# frozen_string_literal: true

# == Schema Information
#
# Table name: message_mentions
#
#  id         :bigint           not null, primary key
#  message_id :integer          not null
#  person_id  :integer          not null
#  location   :integer          default(0), not null
#  length     :integer          default(0), not null
#


RSpec.describe MessageMention, type: :model do
  context 'Validation' do
    describe 'should create a valid message mention' do
      it do
        expect(build(:message_mention)).to be_valid
      end
    end
  end
end
