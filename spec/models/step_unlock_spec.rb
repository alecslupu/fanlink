# frozen_string_literal: true

RSpec.describe StepUnlock, type: :model do
  context 'Associations' do
    describe '#should belong to' do
      it do
        should belong_to(:step).with_primary_key('uuid').with_foreign_key('step_id')
      end
    end

    describe '#should have one' do
      it do
        should have_one(:unlock).class_name('Step').with_primary_key('unlock_id').with_foreign_key('uuid')
      end
    end
  end

  context 'Validation' do
    describe 'should create a valid step unlock' do
      it do
        expect(build(:step_unlock)).to be_valid
      end
    end
  end
end
