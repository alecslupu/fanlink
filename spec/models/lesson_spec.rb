# frozen_string_literal: true

# == Schema Information
#
# Table name: lessons
#
#  id          :bigint           not null, primary key
#  course_id   :integer          not null
#  name        :text             not null
#  description :text             not null
#  start_date  :datetime         not null
#  end_date    :datetime
#  video       :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#


RSpec.describe Lesson, type: :model do
  context 'Validation' do
    describe 'should create a valid lesson' do
      it { expect(build(:lesson)).to be_valid }
    end
  end
end
