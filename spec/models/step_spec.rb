# frozen_string_literal: true

# == Schema Information
#
# Table name: steps
#
#  id             :bigint           not null, primary key
#  quest_id       :integer          not null
#  display        :text
#  deleted        :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  int_unlocks    :integer          default([]), not null, is an Array
#  initial_status :integer          default("locked"), not null
#  reward_id      :integer
#  delay_unlock   :integer          default(0)
#  uuid           :uuid
#  unlocks        :text
#  unlocks_at     :datetime
#


RSpec.describe Step, type: :model do
  context 'Associations' do
    describe '#should belong to' do
      it { should belong_to(:quest).touch(true) }
    end

    describe '#should have one' do
      it { should have_one(:step_completed).class_name('StepCompleted') }
    end

    describe '#should have many' do
      it {should have_many(:quest_activities).order(created_at: :desc)}
      it {should have_many(:quest_completions).class_name('QuestCompletion')}
      it {should have_many(:assigned_rewards)}
      it {should have_many(:rewards).through(:assigned_rewards)}
      it {should have_many(:step_unlocks).with_primary_key('uuid') }
    end
  end

  context 'Validation' do
    describe 'should create a valid step' do
      it { expect(build(:step)).to be_valid }
    end
  end

  context 'Enumeration' do
    describe '#should define initial_status enumerables with values of locked and unlocked' do
      it { should define_enum_for(:initial_status).with([:locked, :unlocked]) }
    end
  end
end
