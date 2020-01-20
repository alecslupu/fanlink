require "spec_helper"

def document_response_without_test!
  before do |example|
    submit_request(example.metadata)
  end

  it "adds documentation without testing the response" do |example|
    # Only check that the response is present
    expect(example.metadata[:response]).to be_present
  end
end

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
    "v4/swagger.json" => {
      swagger: "2.0",
      info: {
        title: "API V4",
        version: "v4",
      },
      securityDefinitions: {
        Bearer: {
          description: "...",
          type: :apiKey,
          name: "Authorization",
          in: :header,
        },
      },
      tags: [
        #{
        #  name: "ActionTypes",
        #  description: "Action types allow the apps to send actions that count towards badge/reward unlocks.(Super Admin Only)",
        #},
        #{
        #  name: "ActivityTypes",
        #  "description": "Activity Types",
        #},
        #{
        #  name: "AssignedRewards",
        #  "description": "This allows admins to assign rewards to other systems. Currently supports ActionType, Quest, Step, and QuestActivity.",
        #},
        {
          name: "BadgeActions",
          description: "Badge Actions",
        },
        {
          name: "Badges",
          description: "Badges",
        },
        #{
        #  name: "Base",
        #},
        #{
        #  name: "Blocks",
        #  description: "Block a person",
        #},
        {
          name: "Categories",
          description: "Categories",
        },
        #{
        #  name: "Events",
        #  description: "Events",
        #},
        {
          name: "Followings",
          description: "Followers and following",
        },
        {
          name: "Interests",
          description: "Interests",
        },
        {
          name: "Levels",
          description: "Levels",
        },
        #{
        #  name: "Merchandise",
        #  description: "Product Merchandise",
        #},
        {
          name: "MessageReports",
          description: "Message Reports",
        },
        {
          name: "Messages",
          description: "Messages",
        },
        {
          name: "NotificationDeviceIds",
          description: "Notification Device IDs",
        },
        {
          name: "PasswordResets",
          description: "Password Reset",
        },
        {
          name: "People",
          description: "Users",
        },
        #{
        #  name: "PostCommentReports",
        #  description: "Reported comments on posts",
        #},
        #{
        #  name: "PostComments",
        #  description: "Comments on a post",
        #},
        #{
        #  name: "PostReactions",
        #  description: "User reactions to a post",
        #},
        #{
        #  name: "PostReports",
        #  description: "Posts reported by a user",
        #},
        #{
        #  name: "Posts",
        #  description: "User/product posts",
        #},
        #{
        #  name: "ProductBeacons",
        #  description: "Beacons assigned to a product",
        #},
        #{
        #  name: "Products",
        #  description: "Products",
        #},
        #{
        #  name: "QuestActivities",
        #  description: "Quest Activities",
        #},
        #{
        #  name: "QuestCompletions",
        #  description: "This is used to register an activity as completed.",
        #},
        #{
        #  name: "Quests",
        #  description: "Quests",
        #},
        #{
        #  name: "RecommendedPeople",
        #  description: "Recommended People",
        #},
        #{
        #  name: "RecommendedPosts",
        #  description: "Recommended posts",
        #},
        {
            name: "Referral",
            description: "Referral system "
        },
        {
          name: "Relationships",
          description: "User's relationships",
        },
        #{
        #  name: "Rewards",
        #  description: "Reward system. Handles linking rewards to various things.",
        #},
        #{
        #  name: "RoomMemberships",
        #  description: "What rooms a user belongs to.",
        #},
        {
          name: "Rooms",
          description: "Chat rooms",
        },
        {
          name: "Session",
          description: "User session management.",
        },
        #{
        #  name: "Steps",
        #  description: "Steps for a quest",
        #},
        #{
        #  name: "Tags",
        #  description: "Tags",
        #},
      ],
      paths: {},
      definitions: {
        certificate_information: {
          type: :object,
          properties: {
            certificate: {
              type: :object,
              properties: {
                name: {type: :string},
                issued_date: {type: :string, format: "date", 'x-nullable': true},
                certificate_image_url: {type: :string},
              },
            },
          },
        },
        CategoryArray: {
          type: :object,
          properties: {
            categories: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  category: { "$ref": "#/definitions/CategoryJson" }
                }
              }
            }
          }
        },
        CategoryJson: {
          type: :object,
          properties: {
            id: {type: :string},
            name: {type: :string},
            product_id: {type: :string},
            color: {type: :string},
            role: {type: :string},
            posts: {
              type: :array,
              items: {
                "$ref": "#/definitions/PostJson"
              }
            }
          },
          "description": "Category Reponse"
        },
        PostJson: {

        },
        BadgeActionsPending: {
          type: :object,
          properties: {
            pending_badge: {
              type: :object,
              properties: {
                badge_action_count: { type: :integer },
                badge: { "$ref": "#/definitions/BadgeJson" }
              }
            },
            badges_awarded: {
              type: :array,
              items: {
                "$ref": "#/definitions/BadgeJson"
              }
            }
          }
        },
        public_person: {
          type: :object,
          properties: {
            id: {type: :string},
            username: {type: :string},
            name: {type: :string, 'x-nullable': true},
            email: {type: :string},
            gender: {type: :string},
            city: {type: :string, 'x-nullable': true},
            country_code: {type: :string, 'x-nullable': true},
            birthdate: {type: :string, format: "date", 'x-nullable': true},
            biography: {type: :string, 'x-nullable': true},
            picture_url: {type: :string, 'x-nullable': true},
            product_account: {type: :boolean},
            recommended: {type: :boolean},
            chat_banned: {type: :boolean},
            tester: {type: :boolean},
            terminated: {type: :boolean},
            terminated_reason: {type: :string, 'x-nullable': true},
            designation: {type: :string, 'x-nullable': true},
            role: {type: :string},
            do_not_message_me: {type: :boolean},
            pin_messages_from: {type: :boolean},
            auto_follow: {type: :boolean},
            num_followers: {type: :integer},
            num_following: {type: :integer},
            facebookid: {type: :string, 'x-nullable': true},
            facebook_picture_url: {type: :string, 'x-nullable': true},
            badge_points: {type: :integer},
            level: {type: :integer, 'x-nullable': true},
            created_at: {type: :string, format: "date-time"},
            updated_at: {type: :string, format: "date-time"},
            following_id: {type: :integer, 'x-nullable': true},
            relationships: {
              type: :array,
              items: {
                "$ref" => "#/definitions/relationships",
              },
            },
          },
        },
        relationships: {
          type: :object,
          properties: {
            id: {type: :string},
            status: {type: :string},
            requested_by: {:type => :object, "$ref" => "#/definitions/public_person"},
            requested_to: {:type => :object, "$ref" => "#/definitions/public_person"},
            created_at: {type: :string, format: "date-time"},
            updated_at: {type: :string, format: "date-time"},
          },
        },
        people: {
          type: :array,
          items: {
            "$ref" => "#/definitions/public_person",
          },
        },
        session_jwt: {
          type: :object,
          properties: {
            person: {
              type: :object,
              properties: {
                id: {type: :string},
                username: {type: :string},
                name: {type: :string, 'x-nullable': true},
                gender: {type: :string},
                city: {type: :string, 'x-nullable': true},
                country_code: {type: :string, 'x-nullable': true},
                birthdate: {type: :string, format: "date", 'x-nullable': true},
                biography: {type: :string, 'x-nullable': true},
                picture_url: {type: :string, 'x-nullable': true},
                product_account: {type: :boolean},
                recommended: {type: :boolean},
                chat_banned: {type: :boolean},
                tester: {type: :boolean},
                terminated: {type: :boolean},
                terminated_reason: {type: :string, 'x-nullable': true},
                designation: {type: :string, 'x-nullable': true},
                role: {type: :string},
                do_not_message_me: {type: :boolean},
                pin_messages_from: {type: :boolean},
                auto_follow: {type: :boolean},
                num_followers: {type: :integer},
                num_following: {type: :integer},
                facebookid: {type: :string, 'x-nullable': true},
                facebook_picture_url: {type: :string, 'x-nullable': true},
                badge_points: {type: :integer},
                level: {type: :integer, 'x-nullable': true},
                created_at: {type: :string, format: "date-time"},
                updated_at: {type: :string, format: "date-time"},
                following_id: {type: :integer, 'x-nullable': true},
                email: {type: :string},
                product: {
                  type: :object,
                  properties: {
                    id: {type: :integer},
                    internal_name: {type: :string},
                    name: {type: :string},
                  },
                },
                level_progress: {type: :integer, 'x-nullable': true},
                rewards: {type: :string, 'x-nullable': true},
                blocked_people: {type: :integer, 'x-nullable': true},
                permissions: {
                  type: :object,
                },
                pin_messages_to: {type: :integer, 'x-nullable': true},
                token: {type: :string},
              },
            },
          },
        },
        person_mini: {
          type: :object,
          properties: {
            id: {type: :string},
            username: {type: :string},
            picture_url: {type: :string},
            designation: {type: :string},
            facebook_picture_url: {type: :string},
            badge_points: {type: :integer},
          },
        },
        trivia_user_subscribed: {
          type: :object,
          properties: {
            game_id: {type: :integer},
            person_id: {type: :integer},
            subscribed: {type: :boolean},
            user_enroled: {type: :boolean},
            user_notification: {type: :boolean},
          },
        },
        trivia_game_prize: {
          type: :object,
          properties: {
            id: {type: :integer},
            game_id: {type: :integer},
            position: {type: :integer},
            photo_url: {type: :string},
            description: {type: :string},
          },
        },
        trivia_round: {
          type: :object,
          properties: {
            id: {type: :integer},
            game_id: {type: :integer},
            start_date: {type: :integer},
            end_date: {type: :integer},
            question_size: {type: :integer},
            complexity: {type: :integer},
            status: {type: :string},
          },
        },
        trivia_round_list: {
          type: :object,
          properties: {
            rounds: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_round",
              },
            },
          },
        },

        trivia_game_prize_list: {
          type: :object,
          properties: {
            prizes: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_game_prize",
              },
            },
          },
        },

        trivia_games_leaderboard_list: {
          type: :object,
          properties: {
            leaderboard: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_games_leaderboard",
              },
            },
          },
          required: ["games"],
        },
        trivia_games_leaderboard: {
          type: :object,
          properties: {
            id: {type: :integer},
            game_id: {type: :integer},
            points: {type: :integer},
            position: {type: :integer},
            average_time: {type: :integer},
            person: {:type => :object, "$ref" => "#/definitions/person_mini"},
          },
        },
        trivia_rounds_leaderboard_list: {
          type: :object,
          properties: {
            leaderboard: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_rounds_leaderboard",
              },
            },
          },
          required: ["games"],
        },
        trivia_rounds_leaderboard: {
          type: :object,
          properties: {
            id: {type: :integer},
            round_id: {type: :integer},
            points: {type: :integer},
            position: {type: :integer},
            average_time: {type: :integer},
            person: {:type => :object, "$ref" => "#/definitions/person_mini"},
          },
        },
        trivia_games_list: {
          type: :object,
          properties: {
            games: {
              type: :array,
              items: {
                "$ref" => "#/definitions/trivia_game",
              },
            },
          },
          required: ["games"],
        },
        trivia_game: {
          type: :object,
          properties: {
            id: {type: :integer},
            start_date: {type: :integer},
            end_date: {type: :integer},
            long_name: {type: :string},
            short_name: {type: :string},
            description: {type: :string},
            round_count: {type: :integer},
            question_count: {type: :integer},
            leaderboard_size: {type: :integer},
            prize_count: {type: :integer},
            room_id: {type: :integer},
            status: {type: :string},
            picture: {type: :string},
            user_enroled: {type: :boolean},
            user_notification: {type: :boolean},
          },
          required: ["trivia_game_id"],
        },
        faulty: {
          type: :object,
          properties: {
            id: {type: :integer},
            faulty: { type: :string }
          },
        },
        SuccessMessage: {
          type: :object,
          properties: {
             message: { type: :string }
          }
        },
        ErrorMessage: {
          type: :object,
          properties: {
             message: { type: :string }
          }
        },
        FollowersArray: {
          type: :object,
          properties: {
            followers: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  badge: { "$ref": "#/definitions/FollowingObject" }
                }
              }
            }
          }
        },
        FollowingObject: {
          type: :object,
          properties: {
            following: { "$ref": "#/definitions/FollowingJson" }
          }
        },
        FollowingJson: {
          type: :object,
          "properties": {
            id: { type: :string },
            follower: { "$ref": "#/definitions/public_person" },
            followed: { "$ref": "#/definitions/public_person" }
          },
          "description": "Following Response"
        },

        BadgeJson: {
          type: :object,
          properties: {
            id: {type: :string},
            "name": {type: :string},
            "internal_name": {type: :string},
            "description": {type: :string,  'x-nullable': true},
            "picture_url": {type: :string},
            action_requirement: {type: :integer},
            point_value: {type: :integer},
          },
          "description": "Badge Response"
        },
        ReferralCode: {
            type: :object,
            properties: {
                person_id: {type: :integer},
                unique_code: {type: :string},
            }
        },
        BadgesArray: {
          type: :object,
          properties: {
            badges: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  badge: { "$ref": "#/definitions/BadgeJson" }
                }
              }
            }
          }
        },
        "LevelJson": {
          type: :object,
          properties: {
            id: { type: :integer },
            name: {type: :string},
            internal_name: {type: :string},
            description: {type: :string},
            points: {type: :integer},
            picture_url: {type: :string},
          },
          "description": "Level Response"
        },
        personMini: {
          type: :object,
          properties: {
            id: {type: :string},
            username: {type: :string},
            picture_url: {type: :string},
            designation: {type: :string},
            facebook_picture_url: {type: :string},
            badge_points: {type: :integer},
            level: {
              "$ref": "#/definitions/LevelJson", 'x-nullable': true
            }
          }
        },
        MiniPeopleArray: {
          type: :object,
          properties: {
            people: {
              type: :array,
              items: {
                "$ref" => "#/definitions/personMini",
              },
            }
          }
        }
      },
    },
  }

  config.swagger_docs["v1/swagger.json"] = JSON.parse(File.read(Rails.root.join("doc/open_api/V1.json")))
  config.swagger_docs["v2/swagger.json"] = JSON.parse(File.read(Rails.root.join("doc/open_api/V2.json")))
  config.swagger_docs["v3/swagger.json"] = JSON.parse(File.read(Rails.root.join("doc/open_api/V3.json")))
end
