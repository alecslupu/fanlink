require 'rails_helper'

RSpec.describe Api::V4::Courseware::Client::CertcoursesController, type: :controller do
  describe 'GET index' do
    it "return error code 401 for a non client user" do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        get :index, params: { person_id: 1, certificate_id: 1 }

        expect(response).to be_unauthorized
      end
    end

    it "return error code 401 for a client user that searches for a person that it's not his assignee" do
      person = create(:person, role: :client)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')

        get :index, params: { person_id: person1.id, certificate_id: 1 }

        expect(response).to be_unauthorized
      end
    end

    it "return error code 422 for a client user that searches for a certificate that does not belong to the assignee" do
      person = create(:person, role: :client)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::ClientToPerson.create(person_id: person1.id, client_id: person.id, status: :active, relation_type: :assigned)

        get :index, params: { person_id: person1.id, certificate_id: 1 }

        expect(response).to be_unprocessable
      end
    end

    it "returns all the certificate's certcourses" do
      person = create(:person, role: :client)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::ClientToPerson.create(person_id: person1.id, client_id: person.id, status: :active, relation_type: :assigned)
        certificate = create(:certificate)
        person1.certificates << certificate

        certcourses = create_list(:certcourse, 3)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourses.first.id, certcourse_order: 1)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourses.second.id, certcourse_order: 2)

        get :index, params: { person_id: person1.id, certificate_id: certificate.id }

        expect(response).to be_successful
        expect(json['certcourses'].count).to eq(2)
        expect(json['certcourses'].map { |cert| cert['id']}.sort).to eq (certcourses.first(2).map(&:id))
      end
    end
  end

  describe "GET show" do
    it "returns all the neccessary information" do
      person = create(:person, role: :client)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        Courseware::Client::ClientToPerson.create(person_id: person1.id, client_id: person.id, status: :active, relation_type: :assigned)
        certificate = create(:certificate)
        person1.certificates << certificate

        certcourse = create(:certcourse)
        CertificateCertcourse.create(certificate_id: certificate.id, certcourse_id: certcourse.id, certcourse_order: 1)
        certcourse_pages = create_list(:certcourse_page, 2, certcourse: certcourse, content_type: "quiz")

        quiz_page1 = create(:quiz_page, is_optional: true, is_survey: false)
        quiz_page1.update(certcourse_page_id: certcourse_pages.first.id) # can't create a quizpage with desired certcorse page
        quiz_page2 = create(:quiz_page, is_optional: false, is_survey: false)
        quiz_page2.update(certcourse_page_id: certcourse_pages.second.id) # can't create a quizpage with desired certcorse page

        answer11 = create(:correct_answer, quiz_page: quiz_page1)
        answer12 = create(:wrong_answers, quiz_page: quiz_page1)

        answer21 = create(:correct_answer, quiz_page: quiz_page2)
        answer22 = create(:wrong_answers, quiz_page: quiz_page2)
        answer23 = create(:wrong_answers, quiz_page: quiz_page2)

        create(:person_quiz, answer: answer11, quiz_page: quiz_page1, person: person1)
        create(:person_quiz, answer: answer12, quiz_page: quiz_page1, person: person1)

        create(:person_quiz, answer: answer21, quiz_page: quiz_page2, person: person1)
        create(:person_quiz, answer: answer22, quiz_page: quiz_page2, person: person1)

        binding.pry
        get :show, params: { person_id: person1.id, certificate_id: certificate.id, id: certcourse.id }

        expect(response).to be_successful
      end
    end
  end
end
