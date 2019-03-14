class ChangeOrderNameToTablenameOrder < ActiveRecord::Migration[5.1]
  def up
  	rename_column :certificates, :order, :certificate_order
  	rename_column :certificate_certcourses, :order, :certcourse_order
  	rename_column :certcourse_pages, :order, :certcourse_page_order
  end

  def down
  	rename_column :certificates, :certificate_order, :order
  	rename_column :certificate_certcourses, :certcourse_order, :order
  	rename_column :certcourse_pages, :certcourse_page_order, :order
  end
end


