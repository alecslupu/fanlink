# frozen_string_literal: true

# == Schema Information
#
# Table name: contests
#
#  id            :bigint           not null, primary key
#  product_id    :integer          not null
#  name          :text             not null
#  internal_name :text
#  description   :text             not null
#  rules_url     :text
#  contest_url   :text
#  status        :integer          default(0)
#  deleted       :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


require 'rails_helper'

RSpec.describe Contest, type: :model do
  context 'Valid factory' do
    it { expect(build(:contest)).to be_valid }
  end

  context 'Validation' do
    it { should validate_presence_of(:name).with_message(_('Name is required')) }
  end

  context 'Associations' do
    it { should belong_to(:product) }
  end

  context 'Methods' do
    describe '.rules_url' do
      it 'should normalize  :rules_url' do
        contest = build(:contest, rules_url: ' SOMEcapsinHereAexample.com ')
        expect(contest.rules_url).to eq('somecapsinhereaexample.com')
      end
    end
    describe '.contest_url' do
      it 'should normalize :contest_url' do
        contest = build(:contest, contest_url: ' SOMEcapsinHere@example.com ')
        expect(contest.contest_url).to eq('somecapsinhere@example.com')
      end
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
