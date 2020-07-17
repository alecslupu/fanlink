# frozen_string_literal: true

# == Schema Information
#
# Table name: badges
#
#  id                       :bigint           not null, primary key
#  product_id               :integer          not null
#  name_text_old            :text
#  internal_name            :text             not null
#  action_type_id           :integer
#  action_requirement       :integer          default(1), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  point_value              :integer          default(0), not null
#  picture_file_name        :string
#  picture_content_type     :string
#  picture_file_size        :integer
#  picture_updated_at       :datetime
#  description_text_old     :text
#  untranslated_name        :jsonb            not null
#  untranslated_description :jsonb            not null
#  issued_from              :datetime
#  issued_to                :datetime
#

include ActionDispatch::TestProcess

FactoryBot.define do
  factory :badge do
    product { current_product }
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
    action_type { create(:action_type) }
    point_value { 10 }
    picture { fixture_file_upload('spec/fixtures/images/better.png', 'image/png') }
  end
end
