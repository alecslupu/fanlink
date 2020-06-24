# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    body = MultiJson.dump('access_token' => 'someRandom stuff',
                          'token_type' => 'Bearer',
                          'expires_in' => 3600)

    stub_request(:post, 'https://www.googleapis.com/oauth2/v4/token')
      .to_return(status: 200, body: body, headers: { 'Content-Type' => 'application/json' })

    stub_request(:patch, 'https://fanlink-development.firebaseio.com/.json')
      .to_return(status: 200, body: '{}', headers: { 'Content-Type' => 'application/json' })
  end
end
