# -*- encoding: utf-8 -*-

require 'rails_helper'

describe AwsController do

  # TODO: auto-generated
  describe 'GET video_transcoded' do
    it 'works' do
      get :video_transcoded, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
