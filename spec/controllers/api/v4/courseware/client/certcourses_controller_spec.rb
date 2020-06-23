# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V4::Courseware::Client::CertcoursesController, type: :controller do
  describe 'GET index' do
    it 'return error code 401 for a non client user' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        get :index, params: { person_id: 1, certificate_id: 1 }

        expect(response).to be_unauthorized
      end
    end

    it "return error code 401 for a client user that searches for a person that it's not his assignee" do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')

        get :index, params: { person_id: person1.id, certificate_id: 1 }

        expect(response).to be_unauthorized
      end
    end

    it 'return error code 422 for a client user that searches for a certificate that does not belong to the assignee' do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)

        get :index, params: { person_id: person1.id, certificate_id: 1 }

        expect(response).to be_unprocessable
      end
    end

    it "returns all the certificate's live certcourses" do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        certificate = create(:certificate)
        person1.certificates << certificate

        certcourses = create_list(:certcourse, 3)
        entry_certcourse = create(:certcourse, status: 'entry')

        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourses.first.id, certcourse_order: 1)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourses.second.id, certcourse_order: 2)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: entry_certcourse.id, certcourse_order: 2)

        get :index, params: { person_id: person1.id, certificate_id: certificate.id }

        expect(response).to be_successful
        expect(json['certcourses'].count).to eq(2)
        expect(json['certcourses'].map { |cert| cert['id'] }.sort).to eq (certcourses.first(2).map(&:id))
      end
    end

    it "returns all the certificate's live certcourses only once even if assigned to multiple certificates" do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        certificate = create(:certificate)
        certificate2 = create(:certificate)
        certificate3 = create(:certificate)
        person1.certificates << certificate
        person1.certificates << certificate2

        certcourses = create_list(:certcourse, 3)
        entry_certcourse = create(:certcourse, status: 'entry')

        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourses.first.id, certcourse_order: 1)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourses.second.id, certcourse_order: 2)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: entry_certcourse.id, certcourse_order: 3)
        CertificateCertcourse.create(certificate_id: certificate2.id, certcourse_id: certcourses.first.id, certcourse_order: 1)
        CertificateCertcourse.create(certificate_id: certificate2.id, certcourse_id: certcourses.second.id, certcourse_order: 2)
        CertificateCertcourse.create(certificate_id: certificate2.id, certcourse_id: entry_certcourse.id, certcourse_order: 3)
        CertificateCertcourse.create(certificate_id: certificate3.id, certcourse_id: certcourses.first.id, certcourse_order: 1)
        CertificateCertcourse.create(certificate_id: certificate3.id, certcourse_id: certcourses.second.id, certcourse_order: 2)
        CertificateCertcourse.create(certificate_id: certificate3.id, certcourse_id: entry_certcourse.id, certcourse_order: 3)

        get :index, params: { person_id: person1.id, certificate_id: certificate.id }
        expect(response).to be_successful
        expect(json['certcourses'].count).to eq(2)
        expect(json['certcourses'].map { |cert| cert['id'] }.sort).to eq (certcourses.first(2).map(&:id))
      end
    end
  end

  describe 'GET show' do
    it 'returns all the neccessary information' do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        certificate = create(:certificate)
        person1.certificates << certificate

        certcourse = create(:certcourse)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourse.id, certcourse_order: 1)
        certcourse_pages = create_list(:certcourse_page, 2, certcourse: certcourse, content_type: 'quiz')

        quiz_page1 = create(:quiz_page, is_optional: true, is_survey: false)
        # quiz_page1.update(certcourse_page_id: certcourse_pages.first.id) # can't create a quizpage with desired certcorse page

        quiz_page2 = create(:quiz_page, is_optional: false, is_survey: false)
        quiz_page2.update(certcourse_page_id: certcourse_pages.second.id) # can't create a quizpage with desired certcorse page

        correct_answer = Answer.find_by(quiz_page_id: quiz_page2.id, is_correct: true)
        correct_answer.update(description: 'Correct answer')

        create(:person_quiz, answer: Answer.where(quiz_page_id: quiz_page2.id).second, quiz_page: quiz_page2, person: person1)
        create(:person_quiz, answer: Answer.where(quiz_page_id: quiz_page2.id).third, quiz_page: quiz_page2, person: person1)
        create(:person_quiz, answer: correct_answer, quiz_page: quiz_page2, person: person1)

        get :show, params: { person_id: person1.id, certificate_id: certificate.id, id: certcourse.id }

        expect(response).to be_successful
        expect(json['quizzes'].count).to eq(1)
        quiz = json['quizzes'].first

        expect(quiz['id']).to eq(quiz_page2.id)
        expect(quiz['is_optional']).to eq(quiz_page2.is_optional)
        expect(quiz['is_survey']).to eq(quiz_page2.is_survey)
        expect(quiz['quiz_text']).to eq(quiz_page2.quiz_text)
        expect(quiz['certcourse_pages_count']).to eq(certcourse.certcourse_pages_count)
        expect(quiz['page_order']).to eq(certcourse_pages.second.certcourse_page_order)
        expect(quiz['no_of_failed_attempts']).to eq(2)
        expect(quiz['answer_text']).to eq(correct_answer.description)
        expect(quiz['is_correct']).to eq(true)
      end
    end

    it 'return error code 404 when the requested certcourse has not quiz page' do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        certificate = create(:certificate)
        person1.certificates << certificate
        certcourse = create(:certcourse)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourse.id, certcourse_order: 1)
        certcourse_pages = create(:certcourse_page, certcourse: certcourse, content_type: 'not_quiz')
        expect(certcourse.certcourse_pages.count).to eq(1)
        get :show, params: { person_id: person1.id, certificate_id: certificate.id, id: certcourse.id }
        expect(response).to be_not_found
        expect(response.body).to include('This certificates has no quiz page.')
      end
    end
  end
end
