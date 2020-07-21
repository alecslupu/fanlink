# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_download_file_pages
#
#  id                    :bigint           not null, primary key
#  course_page_id        :bigint
#  product_id            :bigint
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  caption               :text
#
include ActionDispatch::TestProcess

FactoryBot.define do
  factory :download_file_page, class: 'Fanlink::Courseware::DownloadFilePage'  do
    product { current_product }
    course_page { create(:certcourse_page) }
    document { fixture_file_upload(Rails.root.join(
      'spec/fixtures/documents/blank_test.pdf'), 'application/pdf') }
    caption { Faker::Lorem.words(number: 3) }
  end
end
