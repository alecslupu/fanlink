# frozen_string_literal: true
require 'rails_helper'


RSpec.describe Api::V4::Courseware::Client::CertificatesController, type: :controller do
  describe 'GET index' do
    it "return error code 401 for a non client user" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        get :index, params: { person_id: 1 }

        expect(response).to be_unauthorized
      end
    end

    it "return error code 401 for a client user that searches for a person that it's not his assignee" do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')

        get :index, params: { person_id: person1.id }

        expect(response).to be_unauthorized

      end
    end

    it "return the assignee's certificates" do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        person1.certificates << create_list(:certificate, 2)
        another_certificate = create(:certificate)
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        PersonCertificate.create(person_id: person1.id, certificate_id: person1.certificates.first.id)
        PersonCertificate.create(person_id: person1.id, certificate_id: person1.certificates.second.id)

        login_as(person)

        get :index, params: { person_id: person1.id }

        expect(response).to be_successful
        expect(json['certificates'].count).to eq(2)
        certificates_ids = json['certificates'].map { |c| c['id'].to_i }
        expect(certificates_ids.sort).to eq (person1.certificates.pluck(:id).sort)
      end
    end
  end

  describe 'GET download' do
    it "returns unprocessable (422) if the person certificate does not have the certificate image" do
      person = create(:client_user)
      person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
      Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
      certificate = create(:certificate)
      person1.certificates << certificate
      pc = PersonCertificate.create(person_id: person1.id, certificate_id: certificate.id, issued_certificate_image: nil)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :download, params: { person_id: person1.id, id: certificate.id }

        expect(response).to be_unprocessable
      end
    end
  end
end
