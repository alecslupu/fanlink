class RenameCertcourseIdToCourseId < ActiveRecord::Migration[6.0]
  def change
    rename_column :courseware_certificates_courses, :certcourse_id, :course_id
    rename_column :courseware_certificates_courses, :certcourse_order, :course_order
  end
end
