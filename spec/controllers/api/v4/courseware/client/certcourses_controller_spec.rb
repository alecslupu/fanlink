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

    end
  end
end
