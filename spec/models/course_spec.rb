# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  semester_id :integer          not null
#  name        :text             not null
#  description :text             not null
#  start_date  :datetime         not null
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#


RSpec.describe Course, type: :model do
  context 'Validation' do
    describe 'should create a valid course' do
      it { expect(build(:course)).to be_valid }
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
