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
#

FactoryBot.define do
  factory :trivia_available_answer, class: "Trivia::AvailableAnswer" do
    question { create(:trivia_question) }
    name { "MyString" }
    hint { "MyString" }
    is_correct { false }
  end
end
