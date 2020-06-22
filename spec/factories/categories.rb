# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :text             not null
#  product_id  :integer          not null
#  role        :integer          default("normal"), not null
#  color       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE), not null
#  posts_count :integer          default(0)
#

FactoryBot.define do
  factory :category do
    product { current_product }
    sequence(:name) { |n| "Category #{n}" }
    color { '#FFFFFF' }
    role { 0 }
  end
end
