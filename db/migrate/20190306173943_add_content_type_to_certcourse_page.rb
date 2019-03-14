class AddContentTypeToCertcoursePage < ActiveRecord::Migration[5.1]
  def change
  	add_column :certcourse_pages, :content_type, :string
  end
end
