require 'rails_helper'

RSpec.configure do |config|
  # Specify a root directory where the generated Swagger files will be saved.
  config.swagger_root = Rails.root.to_s + '/docs/rspec_swagger'

  # Define one or more Swagger documents and global metadata for each.
  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      }
    },
    'v2/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V2',
        version: 'v2.0.0'
      }
    },
    'v3/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V3',
        version: 'v3'
      }
    }
  }
end
