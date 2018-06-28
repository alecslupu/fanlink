require 'open_api'
#https://github.com/zhandao/zero-rails_openapi/blob/master/documentation/examples/open_api.rb
OpenApi::Config.tap do |c|
  c.file_output_path = 'doc/open_api'
  #c.doc_location = ['./app/controllers/api/v*/docs/**'],

  c.open_api_docs = {
      V1: {
          base_doc_class: Api::V1::Docs::BaseDoc,
          info: {
              title: 'Fanlink API',
              description: 'API documentation of Rails Application. <br/>' \
                           'Optional multiline or single-line Markdown-formatted description ' \
                           'in [CommonMark](http://spec.commonmark.org/) or `HTML`.',
              version: '1.0.0'
          },
          servers: [
              {
                  url: 'https://api.fan.link',
                  description: 'Production server'
              },{
                  url: 'http://staging.fan.link',
                  description: 'Staging server'
              },{
                url: 'http://localhost:3000',
                description: 'Development server'
              }
          ],
          securitySchemes: {
              SessionCookie: { type: 'apiKey', name: '_fanlink_session', in: 'cookie' },
          },
          global_security: [{ SessionCookie: [] }],
      },
      V2: {
          base_doc_class: Api::V2::Docs::BaseDoc,
          info: {
              title: 'Fanlink API',
              description: 'Fanlink Version 3 API Documentation. <br/>' \
                          'Optional multiline or single-line Markdown-formatted description ' \
                          'in [CommonMark](http://spec.commonmark.org/) or `HTML`.',
              version: '2.0.0'
          },
          servers: [
              {
                  url: 'https://api.fan.link',
                  description: 'Production server'
              },{
                  url: 'http://staging.fan.link',
                  description: 'Staging server'
              },{
                url: 'http://localhost:3000',
                description: 'Development server'
              }
          ],
          securitySchemes: {
              SessionCookie: { type: 'apiKey', name: '_fanlink_session', in: 'cookie' },
          },
          global_security: [{ SessionCookie: [] }],
      },
      V3: {
          base_doc_class: Api::V3::Docs::BaseDoc,
          info: {
              title: 'Fanlink API',
              description: 'API documentation of Rails Application. <br/>' \
                          'Optional multiline or single-line Markdown-formatted description ' \
                          'in [CommonMark](http://spec.commonmark.org/) or `HTML`.',
              version: '3.0.0'
          },
          servers: [
              {
                  url: 'https://api.fan.link',
                  description: 'Production server'
              },{
                  url: 'http://staging.fan.link',
                  description: 'Staging server'
              },{
                url: 'http://localhost:3000',
                description: 'Development server'
              }
          ],
          securitySchemes: {
              SessionCookie: { type: 'apiKey', name: '_fanlink_session', in: 'cookie' },
          },
          global_security: [{ SessionCookie: [] }],
      }
  }
end

Object.const_set('Boolean', 'boolean')
OpenApi.write_docs generate_files: Rails.env.development?
