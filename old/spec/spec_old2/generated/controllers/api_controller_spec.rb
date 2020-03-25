# -*- encoding: utf-8 -*-

require 'rails_helper'

describe ApiController do

  # TODO: auto-generated
  describe 'GET return_the' do
    it 'works' do
      get :return_the, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
