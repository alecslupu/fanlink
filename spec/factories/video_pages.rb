# frozen_string_literal: true

# == Schema Information
#
# Table name: video_pages
#
#  id                 :bigint           not null, primary key
#  certcourse_page_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  video_file_name    :string
#  video_content_type :string
#  video_file_size    :integer
#  video_updated_at   :datetime
#  product_id         :integer          not null
#

FactoryBot.define do
  factory :video_page do
    product { current_product }
    certcourse_page { create(:certcourse_page) }
    video { fixture_file_upload('spec/fixtures/videos/short_video.mp4') }
  end
end
