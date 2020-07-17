# frozen_string_literal: true

# == Schema Information
#
# Table name: action_types
#
#  id                  :bigint           not null, primary key
#  name                :text             not null
#  internal_name       :text             not null
#  seconds_lag         :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  active              :boolean          default(TRUE), not null
#  badge_actions_count :integer
#  badges_count        :integer
#


RSpec.describe ActionType, type: :model do
  context 'Valid factory' do
    it { expect(build(:action_type)).to be_valid }
  end
  context 'Validation' do
    subject { build(:action_type) }
    describe '#presence' do
      it { should validate_presence_of(:internal_name).with_message(_('Internal name is required.')) }
      it { should validate_presence_of(:name).with_message(_('Name is required.')) }
    end
    describe '#length' do
      it {
        should validate_length_of(:internal_name)
          .is_at_least(3)
          .is_at_most(26)
          .with_message(_('Internal name must be between 3 and 26 characters.'))
      }
      it {
        should validate_length_of(:name)
          .is_at_least(3)
          .is_at_most(36)
          .with_message(_('Name must be between 3 and 36 characters.'))
      }
    end
    describe '#uniqueness' do
      it 'should check for uniqueness of name and internal_name' do
        should validate_uniqueness_of(:internal_name)
          .with_message(_('There is already an action type with that internal name.'))
        should validate_uniqueness_of(:name)
          .with_message(_('There is already an action type with that name.'))
      end
    end
    describe '#format' do
      it 'should allow value for internal_name' do
        should allow_value('abc_d12').for(:internal_name)
      end
      it 'should allow value for name' do
        should allow_value('Abc d12').for(:name)
        should allow_value('abc_d12!').for(:name)
      end
      it 'should not allow value for internal_name' do
        should_not allow_value('abc d12').for(:internal_name)
        should_not allow_value('Abcd12').for(:internal_name)
        should_not allow_value('abc_d12!').for(:internal_name)
        should_not allow_value(nil).for(:internal_name)
      end
      it 'should not allow value for name' do
        should_not allow_value(nil).for(:name)
        should_not allow_value('').for(:name)
      end
    end
  end
  context 'Methods' do
    describe '#destroy' do
      subject { create(:action_type) }
      it 'should not let you destroy an action type that has been used in a badge' do
        create(:badge, action_type: subject)
        expect(subject.destroy).to be_falsey
        expect(subject).to exist_in_database
        expect(subject.errors[:base]).not_to be_empty
      end
      it 'should not let you destroy an action type that has been used in a badge action' do
        create(:badge_action, action_type: subject)
        expect(subject.destroy).to be_falsey
        expect(subject).to exist_in_database
        expect(subject.errors[:base]).not_to be_empty
      end
    end
    describe '#in_use?' do
      subject { build(:action_type) }
      it 'is false upon initialization' do
        expect(subject.in_use?).to be_falsey
      end
      it 'marked as used when associated badges exists' do
        subject.badges = build_list(:badge, 3)
        expect(subject.in_use?).to be_truthy
      end
      it 'marked as used when associated badges exists' do
        subject.badge_actions = build_list(:badge_action, 2)
        expect(subject.in_use?).to be_truthy
      end
    end
  end
  context 'Associations' do
    describe "should verify associations haven't changed for" do
      it '#has_many' do
        should have_many(:badges)
        should have_many(:badge_actions)
        should have_many(:assigned_rewards)
        should have_many(:hacked_metrics)
        should have_many(:rewards).through(:assigned_rewards)
      end
    end
  end
end
