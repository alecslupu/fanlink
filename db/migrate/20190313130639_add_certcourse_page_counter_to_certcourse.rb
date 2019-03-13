class AddCertcoursePageCounterToCertcourse < ActiveRecord::Migration[5.1]
  def up
    add_column :certcourse_pages, :certcourse_pages_count, :integer, :default => 0
  end
  
  def down
    remove_column :certcourse_pages, :certcourse_pages_count
  end
end
