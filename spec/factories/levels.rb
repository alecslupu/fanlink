# frozen_string_literal: true

# == Schema Information
#
# Table name: levels
#
#  id                       :bigint           not null, primary key
#  product_id               :integer          not null
#  name_text_old            :text
#  internal_name            :text             not null
#  points                   :integer          default(1000), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  picture_file_name        :string
#  picture_content_type     :string
#  picture_file_size        :integer
#  picture_updated_at       :datetime
#  untranslated_description :jsonb            not null
#  untranslated_name        :jsonb            not null
#

FactoryBot.define do
  factory :level do
    product { current_product }
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
    sequence (:points) { |n| Faker::Number.between(from: n * 10, to: (n * 10 - 1)) }
  end
end
