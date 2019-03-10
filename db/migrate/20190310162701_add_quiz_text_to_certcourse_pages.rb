class AddQuizTextToCertcoursePages < ActiveRecord::Migration[5.1]
  def change
    add_column :certcourse_pages, :quiz_text, :text
  end
end
