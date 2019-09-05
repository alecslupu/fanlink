# == Schema Information
#
# Table name: video_pages
#
#  id                 :bigint(8)        not null, primary key
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
    certcourse_page { nil }
    # video_url { "MyString" }
  end
end
