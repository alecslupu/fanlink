require "bundler/setup"
require 'apigen/migration'
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
  API.migrate(
    ##### Response Models
    AddBadgeActionJsonResponse,
    AddBadgeJsonResponse,
    AddBlockJsonResponse,
    AddEventJsonResponse,
    AddFollowingJsonResponse,
    AddLevelJsonResponse,
    AddMentionJsonResponse,
    AddMerchandiseJsonResponse,
    AddMessageReportJsonResponse,
    AddMessageJsonResponse,
    AddPersonJsonResponse,
    AddPostCommentReportJsonResponse,
    AddPostCommentJsonResponse,
    AddPostReactionJsonResponse,
    AddPostReportJsonResponse,
    AddPostJsonResponse,
    AddRelationJsonResponse,
    AddRoomJsonResponse,
    ##### Endpoints
    AddBadgeActionEndpoints,
    AddBadgeEndpoints,
    AddBlockEndpoints,
    AddEventEndpoints,
    AddFollowingEndpoints,
    AddLevelEndpoints,
    AddMerchandiseEndpoints,
    AddMessageReportEndpoints,
    AddMessageEndpoints,
    AddNotificationDeviceIdEndpoints,
    AddPasswordResetEndpoints,
    AddPersonEndpoints,
    AddPostCommentReportEndpoints,
    AddPostCommentEndpoints,
    AddPostReactionEndpoints,
    AddPostReportEndpoints,
    AddPostEndpoints,
    AddRecommendedPersonEndpoints,
    AddRecommendedPostEndpoints,
    AddRelationshipEndpoints,
    AddRoomMembershipEndpoints,
    AddRoomEndpoints,
    AddSessionEndpoints
  )
  API.validate
  FileUtils.mkdir_p("spec/schema/v1/") unless Dir.exists?("spec/schema/v1/")

  require "apigen/formats/openapi"
  openapi = File.open("docs/specs/OpenApi-V1.yaml", "w")
  openapi << Apigen::Formats::OpenAPI::V3.generate(API)
  openapi.close

  require "apigen/formats/swagger"
  swagger = File.open("docs/specs/Swagger-V1.yaml", "w")
  swagger << Apigen::Formats::Swagger::V2.generate(API)
  swagger.close

  require "apigen/formats/jsonschema"
  v7_draft = JSON.parse(Apigen::Formats::JsonSchema::Draft7.generate(API))
  v7_draft["definitions"].each do |key, definition|
    schema = definition
    schema["$schema"] = v7_draft["$schema"]
    schema_file = File.open("spec/schema/v1/#{key}.json", "w")
    schema_file << JSON.pretty_generate(schema)
    schema_file.close
  end
  # jsonschema = File.open("docs/specs/JsonSchema-V1.yaml", "w")
  # jsonschema << Apigen::Formats::JsonSchema::Draft7.generate(API)
  # jsonschema.close
end
