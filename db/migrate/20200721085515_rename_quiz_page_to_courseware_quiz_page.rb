class RenameQuizPageToCoursewareQuizPage < ActiveRecord::Migration[6.0]
  def change
    rename_table :quiz_pages, :courseware_quiz_pages
    rename_column :courseware_quiz_pages, :certcourse_page_id, :course_page_id
  end
end
