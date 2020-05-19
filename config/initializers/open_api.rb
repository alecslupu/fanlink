# frozen_string_literal: true
# if Rails.env.development?
#   require 'open_api'

#   #load openapi files
#   require File.join(Rails.root, 'docs/oas/api_doc.rb')
#   require File.join(Rails.root, 'docs/oas/v1/base_doc.rb')
#   require File.join(Rails.root, 'docs/oas/v2/base_doc.rb')
#   require File.join(Rails.root, 'docs/oas/v3/base_doc.rb')
#   Dir[File.join('docs/oas', "**", "*.rb")].each { |file| require File.join(Rails.root, file) unless %w[ api_doc.rb base_doc.rb ].include?(file) }

#   #https://github.com/zhandao/zero-rails_openapi/blob/master/documentation/examples/open_api.rb
#   OpenApi::Config.tap do |c|
#     c.file_output_path = 'docs/open_api'
#     #c.doc_location = ['docs/oas/v*/**'],
#     #c.rails_routes_file = 'config/routes.txt'

#     c.open_api_docs = {
#         V1: {
#             base_doc_class: Api::V1::BaseDoc,
#             info: {
#                 title: 'Fanlink API',
#                 description: 'API documentation of Rails Application. <br/>' \
#                             'Optional multiline or single-line Markdown-formatted description ' \
#                             'in [CommonMark](http://spec.commonmark.org/) or `HTML`.',
#                 version: '1.0.0'
#             },
#             servers: [
#                 {
#                     url: 'https://api.fan.link',
#                     description: 'Production server'
#                 },{
#                     url: 'http://staging.fan.link',
#                     description: 'Staging server'
#                 },{
#                   url: 'http://localhost:3000',
#                   description: 'Development server'
#                 }
#             ],
#             securitySchemes: {
#                 SessionCookie: { type: 'apiKey', name: '_fanlink_session', in: 'cookie' },
#             },
#             # global_security: [{ SessionCookie: [] }],
#         },
#         V2: {
#             base_doc_class: Api::V2::BaseDoc,
#             info: {
#                 title: 'Fanlink API',
#                 description: 'Fanlink Version 3 API Documentation. <br/>' \
#                             'Optional multiline or single-line Markdown-formatted description ' \
#                             'in [CommonMark](http://spec.commonmark.org/) or `HTML`.',
#                 version: '2.0.0'
#             },
#             servers: [
#                 {
#                     url: 'https://api.fan.link',
#                     description: 'Production server'
#                 },{
#                     url: 'http://staging.fan.link',
#                     description: 'Staging server'
#                 },{
#                   url: 'http://localhost:3000',
#                   description: 'Development server'
#                 }
#             ],
#             securitySchemes: {
#                 SessionCookie: { type: 'apiKey', name: '_fanlink_session', in: 'cookie' },
#             },
#             global_security: [{ SessionCookie: [] }],
#         },
#         V3: {
#             base_doc_class: Api::V3::BaseDoc,
#             info: {
#                 title: 'Fanlink API',
#                 description: 'API documentation of Rails Application. <br/>' \
#                             'Optional multiline or single-line Markdown-formatted description ' \
#                             'in [CommonMark](http://spec.commonmark.org/) or `HTML`.',
#                 version: '3.0.0'
#             },
#             servers: [
#                 {
#                     url: 'https://api.fan.link',
#                     description: 'Production server'
#                 },{
#                     url: 'http://staging.fan.link',
#                     description: 'Staging server'
#                 },{
#                   url: 'http://localhost:3000',
#                   description: 'Development server'
#                 }
#             ],
#             securitySchemes: {
#                 SessionCookie: { type: 'apiKey', name: '_fanlink_session', in: 'cookie' },
#             },
#             global_security: [{ SessionCookie: [] }],
#         }
#     }
#   end
#   OpenApi.write_docs generate_files: Rails.env.development?
# end
# # Object.const_set('Boolean', 'boolean')
