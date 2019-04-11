# == Schema Information
#
# Table name: trivia_answers
#
#  id                 :bigint(8)        not null, primary key
#  person_id          :bigint(8)
#  trivia_question_id :bigint(8)
#  answered           :string
#  time               :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_correct         :boolean          default(FALSE)
#

FactoryBot.define do
  factory :trivia_answer, class: 'Trivia::Answer' do
    person { nil }
    trivia_question { nil }
    answered { "MyString" }
    time { 1 }
  end
end
