# frozen_string_literal: true

RSpec.describe MessageReport, type: :model do

  context 'Associations' do
    it { should belong_to(:message) }
    it { should belong_to(:person) }
  end
  context 'Validation' do
    subject { create(:message_report) }
    it { is_expected.to define_enum_for(:status).with(MessageReport.statuses.keys) }
    it { should validate_length_of(:reason).is_at_most(500).with_message(_('Reason cannot be longer than 500 characters.')) }

    context 'validates inclusion' do
      it do
        MessageReport.statuses.keys.each do |status|
          expect(build(:message_report, status: status)).to be_valid
        end

        expect { build(:message_report, status: :invalid_status_form_spec) }.to raise_error(/is not a valid status/)
      end
    end
  end

  context 'Scopes' do
    describe '#for_product' do
      it 'responds to' do
        expect(MessageReport).to respond_to(:for_product)
      end
      pending
    end
    describe '#status_filter' do
      it 'responds to' do
        expect(MessageReport).to respond_to(:status_filter)
      end
      pending
    end
  end

  context 'Valid' do
    it 'should create a valid message report' do
      expect(build(:message_report)).to be_valid
    end
  end

  describe '#create' do
    it 'should not let you create a message report without a message' do
      report = build(:message_report, message: nil)
      expect(report).not_to be_valid
      expect(report.errors[:message]).not_to be_empty
    end
    it 'should not let you create a message report without a person' do
      report = build(:message_report, person: nil)
      expect(report).not_to be_valid
      expect(report.errors[:person]).not_to be_empty
    end
  end

  describe '#reason' do
    it 'should not let you give a reason more than 500 characters in length' do
      report = build(:message_report, reason: 'a' * 501)
      expect(report).not_to be_valid
      expect(report.errors[:reason]).not_to be_empty
    end
  end

  describe 'valid_status?' do
    it { expect(MessageReport.valid_status?('pending')).to be_truthy }
    it { expect(MessageReport.valid_status?('no_action_needed')).to be_truthy }
    it { expect(MessageReport.valid_status?('message_hidden')).to be_truthy }
    it { expect(MessageReport.valid_status?('no_status')).to be_falsey }
  end

  # TODO: auto-generated
  describe '#create_time' do
    it 'works' do
      message_report = build(:message_report)
      result = message_report.create_time
      expect(result).not_to be_nil
    end
    pending
  end

  # TODO: auto-generated
  describe '#poster' do
    it 'works' do
      message_report = build(:message_report)
      result = message_report.poster
      expect(result).to eq(message_report.message.person)
    end
    pending
  end

  # TODO: auto-generated
  describe '#reporter' do
    it 'works' do
      message_report = build(:message_report)
      expect(message_report.reporter).to eq(message_report.person)
    end
  end
end
