# == Schema Information
#
# Table name: download_file_pages
#
#  id                    :bigint(8)        not null, primary key
#  certcourse_page_id    :bigint(8)
#  product_id            :bigint(8)
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  caption               :text
#

FactoryBot.define do
  factory :download_file_page do
    CertcoursePage { nil }
  end
end
