require 'rails_helper'

RSpec.describe Api::V4::Courseware::Client::PeopleController, type: :controller do
  describe 'GET index' do

    it "return error code 401 for a non client user" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        get :index

        expect(response).to be_unauthorized
      end
    end

    it "return only the client's assignees" do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        person2 = create(:person, username: 'pers2', email: 'pers2@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        login_as(person)

        get :index

        expect(response).to be_successful
        expect(json['people'].count).to eq(1)
        expect(json['people'].first['id'].to_i).to eq(person1.id)
      end
    end

    it "paginates the answer" do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        person2 = create(:person, username: 'pers2', email: 'pers2@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        Courseware::Client::Assigned.create(person_id: person2.id, client_id: person.id)
        login_as(person)

        get :index, params: {per_page: 1, page: 1}

        expect(response).to be_successful
        expect(person.hired_people.count).to eq(2)
        expect(json['people'].count).to eq(1)
      end
    end

    it 'gets the correct people with username filter' do
      person = create(:client_user)
      ActsAsTenant.with_tenant(person.product) do
        person1 = create(:person, username: 'pers1', email: 'pers1@example.com')
        person2 = create(:person, username: 'pers2', email: 'pers2@example.com')
        person3 = create(:person, username: 'psers3', email: 'pers3@example.com')
        Courseware::Client::Assigned.create(person_id: person1.id, client_id: person.id)
        Courseware::Client::Assigned.create(person_id: person2.id, client_id: person.id)
        Courseware::Client::Assigned.create(person_id: person3.id, client_id: person.id)
        login_as(person)

        get :index, params: {username_filter: 'per'}

        expect(response).to be_successful
        expect(json['people'].count).to eq(2)
        listed_ids = json['people'].map { |p| p["id"].to_i }
        expect(listed_ids.sort).to eq([person1.id, person2.id].sort)
      end
    end
  end
end
