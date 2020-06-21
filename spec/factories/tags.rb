# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id          :bigint(8)        not null, primary key
#  name        :text             not null
#  product_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE), not null
#  posts_count :integer          default(0)
#

FactoryBot.define do
  factory :tag do
    product { current_product }
    sequence(:name) { |n| "Tag #{n}" }
  end
end
