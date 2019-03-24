class AddIsOptionalToCertcoursePages < ActiveRecord::Migration[5.1]
  def change
    add_column :certcourse_pages, :is_optional, :boolean
  end
end
