# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_certificates_courses
#
#  id             :bigint           not null, primary key
#  certificate_id :integer
#  course_id      :integer
#  course_order   :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#

FactoryBot.define do
  factory :certificate_certcourse, class: 'Fanlink::Courseware::CertificatesCourse' do
    product { current_product }
    course { create(:certcourse) }
    certificate { create(:certificate) }
    course_order { Faker::Number.unique(20).between(from: 1, to: 500) }
  end
end
