class AddCoursewareToPortalAccess < ActiveRecord::Migration[5.1]
  def change
    add_column :portal_accesses, :courseware, :integer, default: 0, null: false
  end
end
