# frozen_string_literal: true

# == Schema Information
#
# Table name: rewards
#
#  id                     :bigint           not null, primary key
#  product_id             :integer          not null
#  untranslated_name      :jsonb            not null
#  internal_name          :text             not null
#  reward_type            :integer          default("badge"), not null
#  reward_type_id         :integer          not null
#  series                 :text
#  completion_requirement :integer          default(1), not null
#  points                 :integer          default(0)
#  status                 :integer          default("active"), not null
#  deleted                :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#


RSpec.describe Reward, type: :model do
  context 'Associations' do
    describe '#should belong to' do
      it '#product' do
        should belong_to(:product)
      end
      it '#badge' do
        should belong_to(:badge)
      end
      it '#url' do
        should belong_to(:url)
      end
      it '#coupon' do
        should belong_to(:coupon)
      end
    end

    describe '#should have many' do
      it '#assigned_rewards' do
        should have_many(:assigned_rewards)
      end
      it '#person_rewards' do
        should have_many(:person_rewards)
      end
      it '#reward_progresses' do
        should have_many(:reward_progresses)
      end
      it '#people' do
        should have_many(:people)
      end
      it '#quests' do
        should have_many(:quests)
      end
      it '#steps' do
        should have_many(:steps)
      end
      it '#quest_activities' do
        should have_many(:quest_activities)
      end
      it '#action_types' do
        should have_many(:action_types)
      end
    end
  end

  context 'Validation' do
    describe 'should create a valid reward as' do
      it '#badge reward' do
        expect(build(:badge_reward)).to be_valid
      end
      it '#url reward' do
        expect(build(:url_reward)).to be_valid
      end
      it '#coupon reward' do
        expect(build(:coupon_reward)).to be_valid
      end
    end

    describe 'should validate presense of' do
      it '#internal_name' do
        should validate_presence_of(:internal_name).with_message(_('Internal name is required.'))
      end
    end

    describe 'should validate format of' do
      describe '#internal_name' do
        it 'should allow value for internal_name' do
          should allow_value('abc_d12').for(:internal_name)
        end

        it 'should not allow value for internal_name' do
          should_not allow_value('abc d12').for(:internal_name)
          should_not allow_value('Abcd12').for(:internal_name)
          should_not allow_value('abc_d12!').for(:internal_name)
          should_not allow_value(nil).for(:internal_name)
        end
      end

      describe '#series' do
        it 'should allow value for series' do
          should allow_value('abc_d12').for(:series)
          should allow_value(nil).for(:series)
        end
        it 'should not allow value for series' do
          should_not allow_value('abc d12').for(:series)
          should_not allow_value('Abcd12').for(:series)
          should_not allow_value('abc_d12!').for(:series)
        end
      end
    end

    describe 'should validate length of' do
      subject { build(:badge_reward) }

      it '#internal_name' do
        should validate_length_of(:internal_name)
          .is_at_least(3)
          .is_at_most(26)
          .with_message(_('Internal name must be between 3 and 26 characters.'))
      end

      it '#series' do
        should validate_length_of(:series)
          .is_at_least(3)
          .is_at_most(26)
          .with_message(_('Series must be between 3 and 26 characters.'))
      end
    end

    describe 'should validate uniqueness of' do
      describe '#internal_name' do
        it 'should allow the same internal name for multiple products' do
          reward1 = build(:badge_reward, product: create(:product), internal_name: 'test_123')
          reward2 = build(:badge_reward, product: create(:product), internal_name: 'test_123')

          expect(reward1).to be_valid
          expect(reward2).to be_valid
        end

        it 'should not allow duplicate internal names for the same product' do
          product = create(:product)
          reward1 = create(:badge_reward, product: product, internal_name: 'test_123')
          reward2 = build(:badge_reward, product: product, internal_name: 'test_123')

          expect(reward1).to be_valid
          expect(reward2).not_to be_valid
          expect(reward2.errors[:internal_name]).not_to be_empty
        end
      end

      describe '#reward_type_id' do
        it 'should not allow a reward to be assigned multiple times' do
          product = create(:product)
          badge = create(:badge) # already creates a reward
          reward1 = badge.reward
          reward2 = build(:reward, product: product, reward_type_id: badge.id, reward_type: :badge)

          expect(reward1).to be_valid
          expect(reward2).not_to be_valid
          expect(reward2.errors[:reward_type_id]).not_to be_empty
        end
      end
    end
  end

  context 'Enumeration' do
    describe '#should define reward_type enumerables with values of badge, url and coupon' do
      it do
        should define_enum_for(:reward_type).with([:badge, :url, :coupon])
      end
    end
    describe '#should define status enumerables with values of active and inactive' do
      it do
        should define_enum_for(:status).with([:active, :inactive])
      end
    end
  end
end
