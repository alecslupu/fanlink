# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id                   :bigint(8)        not null, primary key
#  person_id            :integer          not null
#  body_text_old        :text
#  global               :boolean          default(FALSE), not null
#  starts_at            :datetime
#  ends_at              :datetime
#  repost_interval      :integer          default(0), not null
#  status               :integer          default("pending"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  body                 :jsonb            not null
#  priority             :integer          default(0), not null
#  recommended          :boolean          default(FALSE), not null
#  notify_followers     :boolean          default(FALSE), not null
#  audio_file_name      :string
#  audio_content_type   :string
#  audio_file_size      :integer
#  audio_updated_at     :datetime
#  category_id          :integer
#  video_file_name      :string
#  video_content_type   :string
#  video_file_size      :integer
#  video_updated_at     :datetime
#  video_job_id         :string
#  video_transcoded     :jsonb            not null
#  post_comments_count  :integer          default(0)
#  pinned               :boolean          default(FALSE)
#

FactoryBot.define do
  factory :post do
    person { create(:person) }
    global { false }

    after(:create) do |post, evaluator|
      post.body = Globalize.with_locale(I18n.locale) { Faker::Lorem.paragraph }
    end

    factory :recommended_post do
      recommended { true }
    end

    factory :published_post do
      status { :published }
    end
  end
end
