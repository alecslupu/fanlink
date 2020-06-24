# frozen_string_literal: true

RSpec.describe Following, type: :model do
  context 'Valid' do
    it { expect(build(:following)).to be_valid }
  end

  describe ' requires a follower_id' do
    let(:follower) { build(:person) }
    let(:followed) { build(:person, product: follower.product) }
    let(:following) { build(:following, follower: nil, followed: followed) }
    it { expect(following).not_to be_valid }
  end

  describe 'requires a followed_id' do
    let(:follower) { build(:person) }
    let(:following) { build(:following, follower: follower, followed: nil) }

    it { expect(following).not_to be_valid }
  end
end
