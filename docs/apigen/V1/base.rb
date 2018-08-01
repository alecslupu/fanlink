require "bundler/setup"
require "apigen/rest"

module FanlinkApi
  API = Apigen::Rest::Api.new
  API.description "Fanlink API"
  API.version "1.0.0"
  API.servers [
    {
      "url" => "https://api.fan.link",
      "description" => "Production Server"
    },
    {
      "url" => "https://staging.fan.link",
      "description" => "Staging Server"
    },
    {
      "url" => "http://localhost:3000",
      "description" => "Development Server"
    }
  ]
  Dir[File.join(__dir__, "**", "*.rb")].each { |file| require file unless file.include?("base.rb") }
  API.validate


  require "apigen/formats/openapi"
  openapi = File.open("docs/specs/OpenApi-V1.yaml", "w")
  openapi << Apigen::Formats::OpenAPI::V3.generate(API)
  openapi.close

  require "apigen/formats/swagger"
  swagger = File.open("docs/specs/Swagger-V1.yaml", "w")
  swagger << Apigen::Formats::Swagger::V2.generate(API)
  swagger.close

  require "apigen/formats/jsonschema"
  jsonschema = File.open("docs/specs/JsonSchema-V1.yaml", "w")
  jsonschema << Apigen::Formats::JsonSchema::Draft7.generate(API)
  jsonschema.close
end
