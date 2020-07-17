# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_pages
#
#  id                   :bigint           not null, primary key
#  certcourse_page_id   :integer
#  is_optional          :boolean          default(FALSE)
#  quiz_text            :string           default(""), not null
#  wrong_answer_page_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :integer          not null
#  is_survey            :boolean          default(FALSE)
#


require 'rails_helper'

RSpec.describe QuizPage, type: :model do
  describe 'dependencies' do
    it 'destroys dependent answers' do
      quiz_page = create(:quiz_page)
      no_of_quiz_answers = quiz_page.answers.count

      expect { quiz_page.destroy }.to change { Answer.count }.by(-no_of_quiz_answers)
    end
  end
end
