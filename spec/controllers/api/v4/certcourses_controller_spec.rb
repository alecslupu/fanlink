# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V4::CertcoursesController, type: :controller do
  # TODO: auto-generated
  describe 'GET index' do
    pending
  end

  # TODO: auto-generated
  describe 'DELETE destroy' do
    pending
  end

  describe '#show' do
    it 'does not display as selected the wrong_answers' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        qp = create(:quiz_page, that_is_mandatory: true)
        create(:person_quiz, person: person, answer_id: qp.answers.last.id, quiz_page: qp)

        allow(Fanlink::Courseware::Course).to receive(:find).and_return Fanlink::Courseware::Course.find(qp.course_page.course_id)

        get :show, params: { id: qp.course_page.course_id }
        expect(response).to have_http_status(200)

        expect(qp).to exist_in_database

        json['certcourse_pages'][0]['quiz']['answers'].each do |selected_answer|
          expect(selected_answer['is_selected']).to be_falsey
          expect(selected_answer['is_selected']).not_to be_nil
          expect(selected_answer['id']).to eq(qp.answers.where(id: selected_answer['id']).first.id)
        end
      end
    end

    it 'displays the right answer if selected' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        qp = create(:quiz_page, that_is_mandatory: true)
        create(:person_quiz, person: person, answer_id: qp.answers.first.id, quiz_page: qp)

        allow(Fanlink::Courseware::Course).to receive(:find).and_return Fanlink::Courseware::Course.find(qp.course_page.course_id)
        get :show, params: { id: qp.course_page.course_id }

        expect(response).to have_http_status(200)
        expect(qp).to exist_in_database

        json['certcourse_pages'][0]['quiz']['answers'].each do |selected_answer|
          expect(selected_answer['is_selected']).not_to be_nil
          expect(selected_answer['id']).to eq(qp.answers.where(id: selected_answer['id']).first.id)
          expect(selected_answer['is_selected']).to eq(selected_answer['id'] == qp.answers.first.id)
        end
      end
    end
  end
end
