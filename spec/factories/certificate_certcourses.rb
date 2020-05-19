# frozen_string_literal: true
# == Schema Information
#
# Table name: certificate_certcourses
#
#  id               :bigint(8)        not null, primary key
#  certificate_id   :integer
#  certcourse_id    :integer
#  certcourse_order :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :integer          not null
#

FactoryBot.define do
  factory :certificate_certcourse do
    product { current_product }
    certcourse { create(:certcourse) }
    certificate { create(:certificate) }
    certcourse_order { Faker::Number.unique(20).between(from: 1, to: 500) }
  end
end
