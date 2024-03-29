# frozen_string_literal: true

# == Schema Information
#
# Table name: image_pages
#
#  id                 :bigint(8)        not null, primary key
#  certcourse_page_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer          not null
#

FactoryBot.define do
  factory :image_page do
    certcourse_page { create(:certcourse_page) }
    product { current_product }
    image { fixture_file_upload('spec/fixtures/images/large.jpg', 'image/jpeg') }
  end
end
