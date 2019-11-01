# -*- encoding: utf-8 -*-

require 'rails_helper'

describe Admin::PersonCertcoursesController do

  # TODO: auto-generated
  describe 'GET reset_progress' do
    it 'works' do
      get :reset_progress, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO: auto-generated
  describe 'GET forget' do
    it 'works' do
      get :forget, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
