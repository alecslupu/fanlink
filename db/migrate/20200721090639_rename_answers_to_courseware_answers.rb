class RenameAnswersToCoursewareAnswers < ActiveRecord::Migration[6.0]
  def change
    rename_table :answers, :courseware_quiz_page_answers
  end
end
