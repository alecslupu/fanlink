class AddIsSurveyToQuizPage < ActiveRecord::Migration[5.1]
  def change
    add_column :quiz_pages, :is_survey, :boolean, default: false
  end
end
