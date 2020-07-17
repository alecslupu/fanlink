class RenameCertificateCertcoursesCoursewareCertificatesCourses < ActiveRecord::Migration[6.0]
  def change
    rename_table :certificate_certcourses, :courseware_certificates_courses
  end
end
