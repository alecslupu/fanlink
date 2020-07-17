# frozen_string_literal: true

# == Schema Information
#
# Table name: quest_activities
#
#  id                       :bigint           not null, primary key
#  description_text_old     :text
#  hint_text_old            :text
#  deleted                  :boolean          default(FALSE)
#  activity_code            :string
#  picture_file_name        :string
#  picture_content_type     :string
#  picture_file_size        :integer
#  picture_updated_at       :datetime
#  picture_meta             :text
#  untranslated_hint        :jsonb            not null
#  untranslated_description :jsonb            not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  step_id                  :integer          not null
#  reward_id                :integer
#  untranslated_title       :jsonb            not null
#

FactoryBot.define do
  factory :quest_activity do
    hint { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    step { create(:step) }
  end
end
