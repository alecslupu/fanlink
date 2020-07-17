# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :text             not null
#  product_id  :integer          not null
#  role        :integer          default("normal"), not null
#  color       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE), not null
#  posts_count :integer          default(0)
#


RSpec.describe Category, type: :model do
  context 'Validation' do
    describe 'should create a valid category' do
      it { expect(build(:category)).to be_valid }
    end
  end
end
