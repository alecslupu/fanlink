# frozen_string_literal: true

# == Schema Information
#
# Table name: step_unlocks
#
#  id        :bigint           not null, primary key
#  step_id   :uuid             not null
#  unlock_id :uuid             not null
#


RSpec.describe StepUnlock, type: :model do
  context 'Associations' do
    describe '#should belong to' do
      it { should belong_to(:step).with_primary_key(:uuid).touch(true) }

    end

    describe '#should have one' do
      it { should have_one(:unlock).class_name('Step').with_primary_key('unlock_id').with_foreign_key('uuid') }
    end
  end

  context 'Validation' do
    describe 'should create a valid step unlock' do
      it { expect(build(:step_unlock)).to be_valid }
    end
  end
end
