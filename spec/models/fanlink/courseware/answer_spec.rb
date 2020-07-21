# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_quiz_page_answers
#
#  id           :bigint           not null, primary key
#  quiz_page_id :integer
#  description  :string           default(""), not null
#  is_correct   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :integer          not null
#


require 'rails_helper'

RSpec.describe Answer, type: :model do


  # TODO: auto-generated
  describe '#certcourse_name' do
    it 'works' do
      answer = build(:answer)
      expect(answer.course_name).not_to be_nil
    end
    pending
  end
end
