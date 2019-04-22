require "rails_helper"

RSpec.describe Answer, type: :model do

  context "Validation" do

  end

  context "Associations" do
    it { should belong_to(:product) }
    it { should belong_to(:quiz_page) }
    it { should have_many(:user_answers) }
  end

  context "Methods" do
    describe ".is_selected" do
      it "returns false when a wrong_answer is provided" do
        person = create(:person)
        cp1 = create(:certcourse_page, certcourse_page_order: 1)
        cp2 = create(:certcourse_page, certcourse_page_order: 2)
        qp = create(:quiz_page,
          is_optional: false,
          certcourse_page: cp2,
          wrong_answer_page_id: cp1.id
          )

        wrong_answer = create(:wrong_answers, quiz_page: qp)
        create(:person_quiz, person: person, answer_id: wrong_answer.id, quiz_page: qp)

        expect(wrong_answer.is_selected(person)).to be_falsey
        expect(wrong_answer.is_selected(person)).not_to be_nil
      end
      it "return false if the answer is correct, but not selected " do
        person = create(:person)
        cp1 = create(:certcourse_page, certcourse_page_order: 1)
        cp2 = create(:certcourse_page, certcourse_page_order: 2)
        qp = create(:quiz_page,
          is_optional: false,
          certcourse_page: cp2,
          wrong_answer_page_id: cp1.id
          )
        correct_answer = create(:correct_answer, quiz_page: qp)

        expect(correct_answer.is_selected(person)).to be_falsey
        expect(correct_answer.is_selected(person)).not_to be_nil
      end
      it "returns true if the correct answer is provided " do
        person = create(:person)
        cp1 = create(:certcourse_page, certcourse_page_order: 1)
        cp2 = create(:certcourse_page, certcourse_page_order: 2)
        qp = create(:quiz_page,
          is_optional: false,
          certcourse_page: cp2,
          wrong_answer_page_id: cp1.id
          )
        correct_answer = create(:correct_answer, quiz_page: qp)
        create(:person_quiz, person: person, answer_id: correct_answer.id, quiz_page: qp)

        expect(correct_answer.is_selected(person)).to be_truthy
        expect(correct_answer.is_selected(person)).not_to be_nil
      end
    end
  end

  context "Valid factory" do
    it { expect(create(:answer)).to be_valid }
  end
end
