require 'rails_helper'

RSpec.describe Api::V4::CertcoursesController, type: :controller do

  describe "#show" do
    it "does not display as selected the wrong_answers" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        qp = create(:quiz_page, is_optional: false)
        wrong_answers = create_list(:wrong_answers, 4, quiz_page: qp)
        create( :correct_answer, quiz_page: qp )
        create(:person_quiz, person: person, answer_id: wrong_answers.first.id, quiz_page: qp)

        get :show, params: { id: qp.certcourse_page_id }
        expect(response).to have_http_status(200)

        wrong_answers.each_with_index do |value, k|
          selected_answer = json["certcourse_pages"][0]["quiz"]["answers"][k]
          expect(selected_answer["is_selected"]).to be_falsey
          expect(selected_answer["is_selected"]).not_to be_nil
          expect(selected_answer["id"]).to eq(value.id)
        end
      end
    end
    it "displays the right answer if selected" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        qp = create(:quiz_page, is_optional: false)
        wrong_answers = create_list(:wrong_answers, 4, quiz_page: qp)
        correct_answer = create( :correct_answer, quiz_page: qp )
        create(:person_quiz, person: person, answer_id: correct_answer.id, quiz_page: qp)

        get :show, params: { id: qp.certcourse_page_id }
        expect(response).to have_http_status(200)

        wrong_answers.each_with_index do |value, k|
          selected_answer = json["certcourse_pages"][0]["quiz"]["answers"][k]
          expect(selected_answer["is_selected"]).to be_falsey
          expect(selected_answer["is_selected"]).not_to be_nil
          expect(selected_answer["id"]).to eq(value.id)
        end

        selected_answer = json["certcourse_pages"][0]["quiz"]["answers"].last
        expect(selected_answer["is_selected"]).to be_truthy
        expect(selected_answer["is_selected"]).not_to be_nil
        expect(selected_answer["id"]).to eq(correct_answer.id)

      end
    end
  end
end

