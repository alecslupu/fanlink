# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_certificates_courses
#
#  id               :bigint           not null, primary key
#  certificate_id   :integer
#  certcourse_id    :integer
#  certcourse_order :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :integer          not null
#

class CertificateCertcourse < Fanlink::Courseware::CertificatesCourse
  self.table_name = :courseware_certificates_courses
end
