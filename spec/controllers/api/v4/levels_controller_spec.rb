# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V4::LevelsController, type: :controller do
  describe 'GET index' do
    it 'returns all levels with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(
          :level,
          3,
          picture: fixture_file_upload('images/better.png', 'image/png')
        )

        get :index

        expect(response).to have_http_status(200)
        expect(json['levels'].size).to eq(3)
        json['levels'].each do |level|
          expect(level['picture_url']).not_to eq(nil)
          expect(Level.find(level['id']).picture.attached?).to eq(true)
        end
      end
    end
  end

  describe 'GET show' do
    pending
  end

  # TODO: auto-generated
  describe 'POST create' do
    pending
  end

  # TODO: auto-generated
  describe 'PUT update' do
    pending
  end

  # TODO: auto-generated
  describe 'DELETE destroy' do
    pending
  end
end
