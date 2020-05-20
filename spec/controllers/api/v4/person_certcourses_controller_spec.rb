# frozen_string_literal: true
require "rails_helper"

RSpec.describe Api::V4::PersonCertcoursesController, type: :controller do
  describe "#create" do
    it "succesfuly logs the user reply" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        quiz_page = create(:quiz_page)

        post :create, params: { person_certcourse: {
          certcourse_id: quiz_page.certcourse_page.certcourse.id
        }, page_id: quiz_page.certcourse_page.id, answer_id: quiz_page.answers.first.id }

        expect(response).to have_http_status(200)
      end
    end
    describe "fixes FLAPI-864" do
      it "marks the certificate as complete when the last step is not quiz" do
        person = create(:person)
        ActsAsTenant.with_tenant(person.product) do
          login_as(person)
          certificate = create(:certificate)
          certcourse = create(:certcourse)
          create(:certificate_certcourse, certificate: certificate)
          create(:person_certificate, certificate: certificate, person: person, is_completed: false)

          certcourse_page = create(:certcourse_page, certcourse: certcourse)
          image_page = create(:image_page, certcourse_page: certcourse_page)

          post :create, params: { person_certcourse: {
            certcourse_id: certcourse.id
          }, page_id: certcourse_page.id }

          expect(response).to have_http_status(200)
          expect(PersonCertificate.last.is_completed).to eq(false)
        end
      end
      it "marks the certificate as complete when the last step is quiz, and a wrong answer is submitted" do
        person = create(:person)
        ActsAsTenant.with_tenant(person.product) do
          login_as(person)
          certificate = create(:certificate)
          certcourse = create(:certcourse)
          create(:certificate_certcourse, certificate: certificate)
          pc = create(:person_certificate, certificate: certificate, person: person)

          certcourse_page = create(:certcourse_page, certcourse: certcourse)
          quiz_page = create(:quiz_page, certcourse_page: certcourse_page, that_is_mandatory: true)

          person_certcourse = create(:person_certcourse, certcourse: certcourse, person: person,
                                                         is_completed: false, last_completed_page_id: quiz_page.wrong_answer_page_id)

          post :create, params: { person_certcourse: {
            certcourse_id: certcourse.id
          }, page_id: quiz_page.certcourse_page_id, answer_id: quiz_page.answers.last.id }

          expect(response).to have_http_status(200)
          expect(PersonCertificate.last.is_completed).to eq(false)
          expect(PersonCertcourse.last.is_completed).not_to eq(true)
          expect(PersonCertcourse.last.last_completed_page_id).not_to eq(quiz_page.certcourse_page_id)
        end
      end
    end

    describe "fixes FLAPI-779" do
      it "marks the certificate as incomplete when one course is not complete" do
        person = create(:person)
        ActsAsTenant.with_tenant(person.product) do
          login_as(person)

          certificate = create(:certificate)
          certcourse = create(:certcourse)
          create(:certificate_certcourse, certificate: certificate)

          create(:certificate_certcourse, certificate: certificate, certcourse: certcourse)

          create(:person_certificate, certificate: certificate, person: person, is_completed: false)
          certcourse_page = create(:certcourse_page, certcourse: certcourse)
          quiz_page = create(:quiz_page, certcourse_page: certcourse_page)

          create(:person_certcourse, person: person, certcourse: certcourse)

          post :create, params: { person_certcourse: {
            certcourse_id: certcourse.id
          }, page_id: certcourse_page.id, answer_id: quiz_page.answers.first.id }

          expect(response).to have_http_status(200)
          expect(PersonCertificate.last.is_completed).to eq(false)
        end
      end
      it "marks the certificate as incomplete when one course is started but not complete" do
        person = create(:person)
        ActsAsTenant.with_tenant(person.product) do
          login_as(person)

          certificate = create(:certificate)
          certcourse = create(:certcourse)
          certificate_certcourse = create(:certificate_certcourse, certificate: certificate)
          create(:person_certcourse, person: person, certcourse: certificate_certcourse.certcourse, is_completed: false)

          create(:certificate_certcourse, certificate: certificate, certcourse: certcourse)

          create(:person_certificate, certificate: certificate, person: person, is_completed: false)
          certcourse_page = create(:certcourse_page, certcourse: certcourse)
          quiz_page = create(:quiz_page, certcourse_page: certcourse_page)

          create(:person_certcourse, person: person, certcourse: certcourse)

          post :create, params: { person_certcourse: {
            certcourse_id: certcourse.id
          }, page_id: certcourse_page.id, answer_id: quiz_page.answers.first.id }

          expect(response).to have_http_status(200)
          expect(PersonCertificate.last.is_completed).to eq(false)
        end
      end
      it "marks the certificate as complete when both courses are completed" do
        person = create(:person)
        ActsAsTenant.with_tenant(person.product) do
          login_as(person)

          certificate = create(:certificate)
          certcourse = create(:certcourse)
          certificate_certcourse = create(:certificate_certcourse, certificate: certificate)
          create(:person_certcourse, person: person, certcourse: certificate_certcourse.certcourse, is_completed: true)

          create(:certificate_certcourse, certificate: certificate, certcourse: certcourse)

          create(:person_certificate, certificate: certificate, person: person, is_completed: false)
          certcourse_page = create(:certcourse_page, certcourse: certcourse)
          quiz_page = create(:quiz_page, certcourse_page: certcourse_page)

          create(:person_certcourse, person: person, certcourse: certcourse)

          post :create, params: { person_certcourse: {
            certcourse_id: certcourse.id
          }, page_id: certcourse_page.id, answer_id: quiz_page.answers.first.id }

          expect(response).to have_http_status(200)
          expect(PersonCertificate.last.is_completed).to eq(true)
        end
      end
    end
  end
end
