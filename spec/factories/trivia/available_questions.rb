# == Schema Information
#
# Table name: trivia_available_questions
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  cooldown_period :integer
#  time_limit      :integer
#  status          :integer
#  type            :string
#  topic_id        :integer
#  complexity      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :integer          not null
#

FactoryBot.define do

  factory :trivia_available_question, class: "Trivia::SingleChoiceAvailableQuestion" do
    product { current_product }

    title { Faker::Lorem.question(word_count: 10) }
    cooldown_period { 6 }
    time_limit { 10 }
    topic { create(:trivia_topic) }
    complexity { 1 }
    status { :published }

    transient do
      with_answers { true }
      with_two_correct_answers { false }
    end

    after :create do |question, options|
      if options.with_answers
        create :correct_trivia_available_answer, question: question
        create_list :wrong_trivia_available_answer, 3, question: question
      end

      if options.with_two_correct_answers
        create_list :correct_trivia_available_answer, 2, question: question
        create_list :wrong_trivia_available_answer, 3, question: question
      end
    end

    factory :trivia_single_choice_available_question, class: "Trivia::SingleChoiceAvailableQuestion" do
    end
    factory :trivia_multiple_choice_available_question, class: "Trivia::MultipleChoiceAvailableQuestion" do
      transient do
        with_two_correct_answers { true }
      end
    end
    factory :trivia_picture_available_question, class: "Trivia::PictureAvailableQuestion" do
    end
    factory :trivia_boolean_choice_available_question, class: "Trivia::BooleanChoiceAvailableQuestion" do
    end
  end
end
