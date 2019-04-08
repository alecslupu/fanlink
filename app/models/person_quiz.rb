class PersonQuiz < ApplicationRecord
  belongs_to :person
  belongs_to :quiz_page
  belongs_to :answer
end
