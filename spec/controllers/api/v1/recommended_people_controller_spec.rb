# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::RecommendedPeopleController, type: :controller do
  describe '#index' do
    it 'should get all recommended people' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        recommended = create_list(:recommended_person, 2)
        get :index
        expect(response).to be_successful
        people = json['recommended_people'].map { |p| p['id'].to_i }
        expect(people.size).to eq(2)
        expect(people.sort).to eq(recommended.map(&:id))
      end
    end
    it 'should exclude the current user' do
      recomended = create_list(:recommended_person, 2)
      ActsAsTenant.with_tenant(recomended.first.product) do
        login_as(recomended.first)
        get :index
        expect(response).to be_successful
        people = json['recommended_people'].map { |p| p['id'].to_i }
        expect(people.size).to eq(1)
        expect(people.first).to eq(recomended.last.id)
      end
    end
    it 'should exclude followees of the current user' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        followee = create(:recommended_person)
        recommended = create_list(:recommended_person, 2)
        person.follow(followee)
        login_as(person)
        get :index
        expect(response).to be_successful
        people = json['recommended_people'].map { |p| p['id'].to_i }
        expect(people.size).to eq(2)
        expect(people.sort).to eq(recommended.map(&:id))
      end
    end
    it 'displays the recommended people in current product' do
      person = create(:person)
      extra_recommended = create_list(:recommended_person, 2, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        recommended = create_list(:recommended_person, 2)
        get :index
        expect(response).to be_successful
        people = json['recommended_people'].map { |p| p['id'].to_i }
        expect(people.size).to eq(2)
        expect(people.sort).to eq(recommended.map(&:id))
      end
    end
    it 'requires authentication' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        create_list(:recommended_person, 2)
        get :index
        expect(response).to have_http_status(401)
      end
    end
  end
end
