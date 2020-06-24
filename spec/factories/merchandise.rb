# frozen_string_literal: true

# == Schema Information
#
# Table name: merchandise
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  name_text_old        :text
#  description_text_old :text
#  price                :text
#  purchase_url         :text
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  available            :boolean          default(TRUE), not null
#  name                 :jsonb            not null
#  description          :jsonb            not null
#  priority             :integer          default(0), not null
#  deleted              :boolean          default(FALSE), not null
#

FactoryBot.define do
  factory :merchandise do
    product { current_product }
    name { 'MyText' }
    description { 'MyText' }
    price { '$14.00' }
  end
end
