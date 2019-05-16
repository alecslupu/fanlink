require "rails_helper"

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + "/doc/api"
  config.swagger_dry_run = false

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    "v1/swagger.json" => {
      swagger: "2.0",
      info: {
        title: "API V1",
        version: "v1"
      },
      paths: {},

      securityDefinitions: {
        Bearer: {
          description: "...",
          type: :apiKey,
          name: "Authorization",
          in: :header
        }
      }

    },
    "v4/swagger.json" => {
      swagger: "2.0",
      info: {
        title: "API V4",
        version: "v4"
      },
      securityDefinitions: {
        Bearer: {
          description: "...",
          type: :apiKey,
          name: "Authorization",
          in: :header
        }
      },
      paths: {},
      definitions: {
        person_mini: {
          type: :object,
          properties: {
            id:   { type: :string },
            username:  { type: :string },
            picture_url:  { type: :string },
            designation: { type: :string },
            facebook_picture_url:  { type: :string },
            badge_points:  { type: :integer }
          }
        },
        trivia_game_prize: {
          type: :object,
          properties: {
            id: { type: :integer },
            game_id: { type: :integer },
            position: { type: :integer },
            photo_url: { type: :string },
            description: { type: :string }
          }
        },
        trivia_round: {
          type: :object,
          properties: {
            id: { type: :integer },
            game_id: { type: :integer },
            start_date:  { type: :integer },
            end_date:  { type: :integer },
            question_size: { type: :integer },
            complexity: { type: :integer }
          }
        },
        trivia_round_list: {
          type: :object,
          properties: {
            rounds: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_round"
              }
            }
          }
        },

        trivia_game_prize_list: {
          type: :object,
          properties: {
            prizes: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_game_prize"
              }
            }
          }
        },

        trivia_games_leaderboard_list: {
          type: :object,
          properties: {
            leaderboard: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_games_leaderboard"
              }
            }
          },
          required: ["games"]
        },
        trivia_games_leaderboard: {
          type: :object,
          properties: {
            id: { type: :integer },
            game_id: { type: :integer },
            points: { type: :integer },
            position: { type: :integer },
            average_time: { type: :integer },
            person: { type: :object, "$ref" => "#/definitions/person_mini" }
          }
        },
        trivia_rounds_leaderboard_list: {
          type: :object,
          properties: {
            leaderboard: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_games_leaderboard"
              }
            }
          },
          required: ["games"]
        },
        trivia_rounds_leaderboard: {
          type: :object,
          properties: {
            id: { type: :integer },
            round_id: { type: :integer },
            points: { type: :integer },
            position: { type: :integer },
            average_time: { type: :integer },
            person: { type: :object, "$ref" => "#/definitions/person_mini" }
          }
        },
        trivia_games_list: {
          type: :object,
          properties: {
            games: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_game"
              }
            }
          },
          required: ["games"]
        },
        trivia_game: {
          type: :object,
          properties: {
              id: { type: :integer },
              start_date:{ type: :integer },
              end_date:{ type: :integer },
              long_name: { type: :string },
              short_name: { type: :string },
              description: { type: :string },
              round_count: { type: :integer },
              question_count: { type: :integer },
              leaderboard_size: { type: :integer },
              prize_count: { type: :integer },
              room_id: { type: :integer },
              user_enroled: { type: :boolean },
              user_notification: { type: :boolean }
          },
          required: ['trivia_game_id']
        }
      }
    }
  }
end
