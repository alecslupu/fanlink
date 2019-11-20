# -*- encoding: utf-8 -*-

require 'rails_helper'

describe Admin::MessagesController do

  # TODO: auto-generated
  describe 'GET hide' do
    it 'works' do
      get :hide, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO: auto-generated
  describe 'GET index' do
    it 'works' do
      get :index, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO: auto-generated
  describe 'GET unhide' do
    it 'works' do
      get :unhide, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
