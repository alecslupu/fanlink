# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_available_answers
#
#  id                 :bigint(8)        not null, primary key
#  trivia_question_id :bigint(8)
#  name               :string
#  hint               :string
#  is_correct         :boolean          default(FALSE), not null
#  status             :integer          default("draft"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#

FactoryBot.define do
  factory :trivia_available_answer, class: "Trivia::AvailableAnswer" do
    product { current_product }

    question { create(:trivia_available_question) }
    name { Faker::Lorem.question }
    hint { Faker::Lorem.paragraph }
    is_correct { false }
    status { :published }

    factory :correct_trivia_available_answer do
      is_correct { true }
    end

    factory :wrong_trivia_available_answer do
      is_correct { false }
    end
  end
end
