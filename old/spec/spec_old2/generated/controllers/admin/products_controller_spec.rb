# -*- encoding: utf-8 -*-

require 'rails_helper'

describe Admin::ProductsController do

  # TODO: auto-generated
  describe 'GET select' do
    it 'works' do
      get :select, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO: auto-generated
  describe 'GET select_form' do
    it 'works' do
      get :select_form, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
