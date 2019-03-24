class AddCertcoursePageCounterToCertcourseFix < ActiveRecord::Migration[5.1]
  def change
  	add_column :certcourses, :certcourse_pages_count, :integer, :default => 0
    remove_column :certcourse_pages, :certcourse_pages_count, :integer, :default => 0
  end
end
