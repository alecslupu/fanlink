require "rails_helper"

RSpec.describe Api::V4::CertcoursesController, type: :controller do

  # TODO: auto-generated
  describe "GET index" do
    pending
  end

  # TODO: auto-generated
  describe "DELETE destroy" do
    pending
  end


  describe "#show" do
    it "does not display as selected the wrong_answers" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        qp = create(:quiz_page, that_is_mandatory: true)
        create(:person_quiz, person: person, answer_id: qp.answers.last.id, quiz_page: qp)

        get :show, params: { id: qp.certcourse_page_id }
        expect(response).to have_http_status(200)

        qp.answers.order(id: :desc).each_with_index do |value, k|
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
        qp = create(:quiz_page, that_is_mandatory: true)
        create(:person_quiz, person: person, answer_id: qp.answers.first.id, quiz_page: qp)

        get :show, params: { id: qp.certcourse_page_id }
        expect(response).to have_http_status(200)

        selected_answer = json["certcourse_pages"][0]["quiz"]["answers"].last
        expect(selected_answer["is_selected"]).to be_truthy
        expect(selected_answer["is_selected"]).not_to be_nil
        expect(selected_answer["id"]).to eq(qp.answers.first.id)

        qp.answers.order(id: :desc).each_with_index do |value, k|
          selected_answer = json["certcourse_pages"][0]["quiz"]["answers"][k]
          next if selected_answer['id'] == qp.answers.first.id

          expect(selected_answer["is_selected"]).to be_falsey
          expect(selected_answer["is_selected"]).not_to be_nil
          expect(selected_answer["id"]).to eq(value.id)
        end

      end
    end
  end
end
