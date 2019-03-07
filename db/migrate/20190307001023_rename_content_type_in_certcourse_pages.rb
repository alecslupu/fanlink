class RenameContentTypeInCertcoursePages < ActiveRecord::Migration[5.1]
  def up
    rename_column :certcourse_pages, :content_type, :type
  end
  def down
    rename_column :certcourse_pages, :type, :content_type
  end
end
