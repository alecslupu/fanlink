# -*- encoding: utf-8 -*-

require 'rails_helper'

describe RailsAdminController do

  # TODO: auto-generated
  describe 'GET not_authenticated' do
    it 'works' do
      get :not_authenticated, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO: auto-generated
  describe 'GET require_login' do
    it 'works' do
      get :require_login, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
