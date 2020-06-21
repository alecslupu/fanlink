# frozen_string_literal: true

require "rails_helper"

RSpec.describe QuizPage, type: :model do
  describe "dependencies" do
    it "destroys dependent answers" do
      quiz_page = create(:quiz_page)
      no_of_quiz_answers = quiz_page.answers.count

      expect { quiz_page.destroy }.to change { Answer.count }.by(-no_of_quiz_answers)
    end
  end
end
