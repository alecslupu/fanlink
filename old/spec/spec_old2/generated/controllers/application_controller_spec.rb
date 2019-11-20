# -*- encoding: utf-8 -*-

require 'rails_helper'

describe ApplicationController do

  # TODO: auto-generated
  describe 'GET status' do
    it 'works' do
      get :status, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
