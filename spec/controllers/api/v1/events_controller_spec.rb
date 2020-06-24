# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe '#index' do
    it 'should get all the events in a product' do
      person = create(:person)

      3.times do
        create(:event, product: create(:product))
      end
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        events = create_list(:event, 2)
        get :index
        expect(response).to have_http_status(200)
        expect(json['events'].count).to eq(events.size)
        json['events'].each do |event|
          expect(event_json(event)).to be_truthy
        end
      end
    end
    it 'should get all the events' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        events = create_list(:event, 2)
        pe = create(:past_event)
        fe = create(:future_event)
        expected = events + [pe, fe]
        get :index
        expect(response).to have_http_status(200)
        expect(json['events'].count).to eq(expected.size)
        json['events'].each do |event|
          expect(event_json(event)).to be_truthy
        end
      end
    end
    it 'should get events specifying one start time' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        events = create_list(:event, 2)
        pe = create(:past_event)
        fe = create(:future_event)
        expected = events + [fe]
        get :index, params: { from_date: Time.zone.now.strftime('%Y-%m-%d') }
        expect(response).to have_http_status(200)
        expect(json['events'].count).to eq(expected.size)
        json['events'].each do |event|
          expect(event_json(event)).to be_truthy
        end
      end
    end
    it 'should get events specifying a start time range' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        events = create_list(:event, 2)
        pe = create(:past_event)
        fe = create(:future_event)
        expected = events + [fe]
        get :index, params: {
          from_date: Time.zone.now.strftime('%Y-%m-%d'), to_date: 10.days.from_now.strftime('%Y-%m-%d')
        }
        expect(response).to have_http_status(200)
        expect(json['events'].count).to eq(events.size)
        json['events'].each do |event|
          expect(event_json(event)).to be_truthy
        end
      end
    end
    it 'should not get the events if not logged in' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index, params: {
          from_date: Time.zone.now.strftime('%Y-%m-%d'), to_date: 10.days.from_now.strftime('%Y-%m-%d')
        }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe '#show' do
    it 'should get a single event' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        event = create(:event)
        get :show, params: { id: event.id }
        expect(response).to have_http_status(200)
        expect(event_json(json['event'])).to be_truthy
      end
    end
    it 'should not get the event if not logged in' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        event = create(:event)
        get :show, params: { id: event.id }
        expect(response).to have_http_status(401)
      end
    end
    it 'should not get event if from a different product' do
      person = create(:person)
      event = create(:event, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :show, params: { id: event.id }
        expect(response).to have_http_status(404)
      end
    end
  end
end
