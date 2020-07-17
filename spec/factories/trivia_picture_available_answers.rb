# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_picture_available_answers
#
#  id                   :bigint           not null, primary key
#  question_id          :bigint
#  is_correct           :boolean          default(FALSE), not null
#  status               :integer          default("draft"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  product_id           :integer          not null
#

FactoryBot.define do
  factory :trivia_picture_available_answer, class: 'Trivia::PictureAvailableAnswer' do
    product { current_product }
  end
end
