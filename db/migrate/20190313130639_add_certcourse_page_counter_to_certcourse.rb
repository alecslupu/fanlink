class AddCertcoursePageCounterToCertcourse < ActiveRecord::Migration[5.1]
  def change
    add_column :certcourse_pages, :certcourse_pages_count, :integer, :default => 0
  end
end
