# == Schema Information
#
# Table name: contents
#
#  id           :bigint(8)        not null, primary key
#  content      :content          default "", not null
#  title        :string           not null
#  product_id   :integer          not null
#  slug         :string           not null

FactoryBot.define do
  factory :static_content do
    product { current_product }
    title { Faker::Lorem.sentence() }
    content { Faker::Lorem.sentence() }
  end
end
