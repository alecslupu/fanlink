# frozen_string_literal: true

require 'rails_helper'

def document_response_without_test!
  before do |example|
    submit_request(example.metadata)
  end

  it 'adds documentation without testing the response' do |example|
    # Only check that the response is present
    expect(example.metadata[:response]).to be_present
  end
end

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/doc/api'
  config.swagger_dry_run = false

  # Define one or more Swagger documents and provide global metadata for each
  # one When you run the 'rswag:specs:to_swagger' rake task, the complete
  # Swagger will be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag
  # to the root example_group in your specs, e.g. describe '...',
  # swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v4/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V4',
        version: 'v4'
      },
      securityDefinitions: {
        Bearer: {
          description: '...',
          type: :apiKey,
          name: 'Authorization',
          in: :header
        }
      },
      tags: [
        # {
        #  name: "ActionTypes",
        #  description: "Action types allow the apps to send actions that count
        #   towards badge/reward unlocks.(Super Admin Only)",
        # },
        # {
        #  name: "ActivityTypes",
        #  description: "Activity Types",
        # },
        # {
        #  name: "AssignedRewards",
        #  description: "This allows admins to assign rewards to other systems.
        # Currently supports ActionType, Quest, Step, and QuestActivity.",
        # },
        {
          name: 'BadgeActions',
          description: 'Badge Actions'
        },
        {
          name: 'Badges',
          description: 'Badges'
        },
        # {
        #  name: "Base",
        # },
        {
         name: "Blocks",
         description: "Block a person",
        },
        {
          name: 'Categories',
          description: 'Categories'
        },
        # {
        #  name: "Events",
        #  description: "Events",
        # },
        {
          name: 'Followings',
          description: 'Followers and following'
        },
        {
          name: 'Interests',
          description: 'Interests'
        },
        {
          name: 'Levels',
          description: 'Levels'
        },
        # {
        #  name: "Merchandise",
        #  description: "Product Merchandise",
        # },
        {
          name: 'MessageReports',
          description: 'Message Reports'
        },
        {
          name: 'Messages',
          description: 'Messages'
        },
        {
          name: 'NotificationDeviceIds',
          description: 'Notification Device IDs'
        },
        {
          name: 'PasswordResets',
          description: 'Password Reset'
        },
        {
          name: 'People',
          description: 'Users'
        },
        {
          name: 'PostCommentReports',
          description: 'Reported comments on posts'
        },
        {
          name: 'PostComments',
          description: 'Comments on a post'
        },
        # {
        #  name: "PostReactions",
        #  description: "User reactions to a post",
        # },
        {
          name: 'PostReports',
          description: 'Posts reported by a user'
        },
        {
          name: 'Posts',
          description: 'User/product posts'
        },
        # {
        #  name: "ProductBeacons",
        #  description: "Beacons assigned to a product",
        # },
        # {
        #  name: "Products",
        #  description: "Products",
        # },
        # {
        #  name: "QuestActivities",
        #  description: "Quest Activities",
        # },
        # {
        #  name: "QuestCompletions",
        #  description: "This is used to register an activity as completed.",
        # },
        # {
        #  name: "Quests",
        #  description: "Quests",
        # },
        # {
        #  name: "RecommendedPeople",
        #  description: "Recommended People",
        # },
        # {
        #  name: "RecommendedPosts",
        #  description: "Recommended posts",
        # },
        {
          name: 'Referral',
          description: 'Referral system '
        },
        {
          name: 'Relationships',
          description: "User's relationships"
        },
        # {
        #  name: "Rewards",
        #  description: "Handles linking rewards to various things.",
        # },
        # {
        #  name: "RoomMemberships",
        #  description: "What rooms a user belongs to.",
        # },
        {
          name: 'Rooms',
          description: 'Chat rooms'
        },
        {
          name: 'Session',
          description: 'User session management.'
        },
        # {
        #  name: "Steps",
        #  description: "Steps for a quest",
        # },
        {
          name: 'Tags',
          description: 'Tags'
        }
      ],
      paths: {},
      definitions: {
        BadgeJson: {
          type: :object,
          properties: {
            id: {type: :string},
            name: {type: :string},
            internal_name: {type: :string},
            description: {type: :string, 'x-nullable': true},
            picture_url: {type: :string},
            action_requirement: {type: :integer},
            point_value: {type: :integer}
          },
          description: 'Badge Response'
        },
        BadgeActionsPending: {
          type: :object,
          properties: {
            pending_badge: {
              type: :object,
              properties: {
                badge_action_count: {type: :integer},
                badge: {"$ref": '#/definitions/BadgeJson'}
              }
            },
            badges_awarded: {
              type: :array,
              items: {"$ref": '#/definitions/BadgeJson'}
            }
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
                  badge: {"$ref": '#/definitions/BadgeJson'}
                }
              }
            }
          }
        },

        PeopleArray: {
          type: :object,
          properties: {
            people: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  person: {"$ref": '#/definitions/PersonJson'}
                }
              }
            }
          }
        },
        BlocksObject: {
          type: :object,
          properties: {
            block: {
              id: { type: :integer },
              blocker_id: { type: :integer },
              blocked_id: { type: :integer },
            }
          }
        },
        PersonObject: {
          type: :object,
          properties: {
            person: {"$ref": '#/definitions/PersonJson'}
          }
        },
        PostCommentReportsArray: {
          type: :object,
          properties: {
            post_comment_reports: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  post_comment_report: {
                    "$ref": '#/definitions/PostCommentReportJson'
                  }
                }
              }
            }
          }
        },

        PostCommentReportJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            created_at: {type: :string, format: 'date-time'},
            post_comment_id: {type: :integer},
            commenter: {type: :string},
            reporter: {type: :string},
            reason: {type: :string},
            status: {type: :string}
          },
          description: 'Post Comment Report Response'
        },

        PostCommentsArray: {
          type: :object,
          properties: {
            post_comments: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  post_comment: {"$ref": '#/definitions/PostCommentJson'}
                }
              }
            }
          }
        },
        PostCommentJson: {
          type: :object,
          properties: {
            id: {type: :string},
            create_time: {type: :string, format: 'date-time'},
            body: {type: :string},
            mentions: {
              type: :array,
              'x-nullable': true,
              items: {"$ref": '#/definitions/MentionJson'}
            },
            person: {"$ref": '#/definitions/PersonJson'}
          },
          description: 'Post Comment Response'
        },
        MentionJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            person_id: {type: :integer},
            location: {type: :integer},
            length: {type: :integer}
          },
          description: 'Notification Type ID Response'
        },
        PostCommentsObject: {
          type: :object,
          properties: {
            post_comment: {"$ref": '#/definitions/PostCommentJson'}
          }
        },
        PostReactionJson: {
          type: :object,
          properties: {
            id: {type: :string},
            post_id: {type: :integer},
            person_id: {type: :integer},
            reaction: {type: :string}
          },
          description: 'Post Reaction Response'
        },
        PollOptionVoteJson: {
          type: :object,
          properties: {
            id: {type: :string},
            description: {type: :string},
            numberOfVotes: {type: :integer},
            voted: {type: :boolean}
          }
        },
        PollOptionObject: {
          type: :object,
          properties: {
            poll: {
              type: :array,
              items: {"$ref": '#/definitions/PollOptionVoteJson'}
            }
          }
        },
        PostReactionsObject: {
          type: :object,
          properties: {
            post_reaction: {"$ref": '#/definitions/PostReactionJson'}
          }
        },
        FollowingObject: {
          type: :object,
          properties: {
            following: {"$ref": '#/definitions/FollowingJson'}
          }
        },
        FollowingJson: {
          type: :object,
          properties: {
            id: {type: :string},
            follower: {"$ref": '#/definitions/PersonJson'},
            followed: {"$ref": '#/definitions/PersonJson'}
          },
          description: 'Following Response'
        },
        "FollowersArray": {
          type: :object,
          properties: {
            followers: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  follower: {"$ref": '#/definitions/FollowingJson'}
                }
              }
            }
          }
        },

        LevelsArray: {
          type: :object,
          properties: {
            levels: {
              type: :array,
              items: {"$ref": '#/definitions/LevelJson'}
            }
          }
        },

        LevelJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            name: {type: :string},
            internal_name: {type: :string},
            description: {type: :string},
            points: {type: :integer},
            picture_url: {type: :string}
          },
          description: 'Level Response'
        },
        MessageReportsArray: {
          type: :object,
          properties: {
            message_reports: {
              type: :array,
              items: {"$ref": '#/definitions/MessageReportJson'}
            }
          }
        },

        "MessageReportJson": {
          type: :object,
          properties: {
            "id": {
              type: :integer
            },
            "created_at": {
              type: :string,
              "format": 'date-time'
            },
            "updated_at": {
              type: :string,
              "format": 'date-time'
            },
            "message_id": {
              type: :integer
            },
            "poster": {
              type: :object,
              "$ref": '#/definitions/PersonJson'
            },
            "reporter": {
              type: :object,
              "$ref": '#/definitions/PersonJson'
            },
            "reason": {
              type: :string
            },
            "status": {
              type: :string
            }
          },
          description: 'Message Report Response'
        },

        "RelationshipJson": {
          type: :object,
          properties: {
            "id": {
              type: :string
            },
            "status": {
              type: :string
            },
            "create_time": {
              type: :string,
              "format": 'date-time'
            },
            "update_time": {
              type: :string,
              "format": 'date-time'
            },
            "requested_by": {
              "$ref": '#/definitions/PersonJson'
            },
            "requested_to": {
              "$ref": '#/definitions/PersonJson'
            }
          },
          description: 'Relationship Response'
        },
        "PersonJson": {
          type: :object,
          properties: {
            "id": {
              type: :string
            },
            "username": {
              type: :string
            },
            "name": {
              type: :string, 'x-nullable': true
            },
            "gender": {
              type: :string
            },
            "city": {
              type: :string, 'x-nullable': true
            },
            "biography": {
              type: :string, 'x-nullable': true
            },
            "country_code": {
              type: :string, 'x-nullable': true
            },
            "birthdate": {
              type: :string, format: 'date', 'x-nullable': true
            },
            "picture_url": {
              type: :string, 'x-nullable': true
            },
            "product_account": {
              type: :boolean
            },
            "recommended": {
              type: :boolean
            },
            "chat_banned": {
              type: :boolean
            },
            "designation": {
              type: :string, 'x-nullable': true
            },
            "following_id": {
              type: :integer, 'x-nullable': true
            },
            "relationships": {
              type: :array,
              items: {
                "$ref": '#/definitions/RelationshipJson'
              }
            },
            "badge_points": {
              type: :integer
            },
            "role": {
              type: :string
            },
            "level": {
              type: :string, 'x-nullable': true
            },
            "do_not_message_me": {
              type: :boolean
            },
            "pin_messages_from": {
              type: :boolean
            },
            "auto_follow": {
              type: :boolean
            },
            "num_followers": {
              type: :integer
            },
            "num_following": {
              type: :integer
            },
            "facebookid": {
              type: :string, 'x-nullable': true
            },
            "facebook_picture_url": {
              type: :string, 'x-nullable': true
            },
            "created_at": {
              type: :string,
              "format": 'date-time'
            },
            "updated_at": {
              type: :string,
              "format": 'date-time'
            }
          },
          description: 'Person Response'
        },

        "PostsObject": {
          type: :object,
          properties: {
            "post": {
              "$ref": '#/definitions/PostJson'
            }
          }
        },
        "PostsArray": {
          type: :object,
          properties: {
            "posts": {
              type: :array,
              items: {
                type: :object,
                properties: {
                  "post": {
                    "$ref": '#/definitions/PostJson'
                  }
                }
              }
            }
          }
        },
        "MessagesArray": {
          properties: {
            "messages": {
              type: :array,
              items: {
                type: :object,
                properties: {
                  "message": {
                    "$ref": '#/definitions/MessageJson'
                  }
                }
              }
            }
          }
        },
        "MessagesObject": {
          type: :object,
          properties: {
            "message": {
              "$ref": '#/definitions/MessageJson'
            }
          }
        },

        "MessageJson": {
          type: :object,
          properties: {
            "id": {
              type: :integer
            },
            "create_time": {
              type: :string,
              "format": 'date-time'
            },
            "body": {
              type: :string
            },
            "picture_url": {
              type: :string, 'x-nullable': true
            },
            "audio_url": {
              type: :string, 'x-nullable': true
            },
            "audio_size": {
              type: :string, 'x-nullable': true
            },
            "audio_content_type": {
              type: :string, 'x-nullable': true
            },
            "person": {
              "$ref": '#/definitions/PersonJson'
            },

            "mentions": {
              type: :array, 'x-nullable': true,
              items: {
                "$ref": '#/definitions/MentionJson'
              }
            }
          },
          description: 'Message Response'
        },

        "RelationshipsArray": {
          type: 'object',
          properties: {
            "relationships": {
              type: :array,
              items: {
                type: 'object',
                properties: {
                  "relationship": {
                    "$ref": '#/definitions/RelationshipJson'
                  }
                }
              }
            }
          }
        },
        "RelationshipsObject": {
          type: :object,
          properties: {
            "relationship": {
              "$ref": '#/definitions/RelationshipJson'
            }
          }
        },

        "RoomsArray": {
          type: :object,
          properties: {
            "rooms": {
              type: :array,
              items: {
                type: :object,
                properties: {
                  "room": {
                    "$ref": '#/definitions/RoomJson'
                  }
                }
              }
            }
          }
        },
        "RoomJson": {
          type: :object,
          properties: {
            "id": {
              type: :integer
            },
            "name": {
              type: :string
            },
            description: {
              type: :string, 'x-nullable': true
            },
            "owned": {
              type: :boolean
            },
            "picture_url": {
              type: :string, 'x-nullable': true
            },
            "public": {
              type: :boolean
            },
            "members": {
              type: :array,
              items: {
                type: :object,
                properties: {
                  "member": {
                    "$ref": '#/definitions/PersonJson'
                  }
                }
              }
            }
          },
          description: 'Room Response'
        },

        "SessionObject": {
          type: :object,
          properties: {
            "person": {
              "$ref": '#/definitions/PersonJson'
            }
          }
        },
        "RoomsObject": {
          type: :object,
          properties: {
            "room": {
              "$ref": '#/definitions/RoomJson'
            }
          }
        },
        "RecommendedPostsArray": {
          type: :object,
          properties: {
            "posts": {
              type: :array,
              items: {
                type: :object,
                properties: {
                  "post": {
                    "$ref": '#/definitions/PostJson'
                  }
                }
              }
            }
          }
        },
        "PostJson": {
          type: :object,
          properties: {
            "id": {
              type: :integer
            },
            "create_time": {
              type: :string,
              "format": 'date-time'
            },
            "body": {
              type: :string, 'x-nullable': true
            },
            "picture_url": {
              type: :string, 'x-nullable': true
            },
            "audio_url": {
              type: :string, 'x-nullable': true
            },
            "audio_size": {
              type: :integer, 'x-nullable': true
            },
            "audio_content_type": {
              type: :string, 'x-nullable': true
            },
            "person": {
              "$ref": '#/definitions/PersonJson'
            },
            "post_reaction_counts": {
              type: :integer, 'x-nullable': true
            },
            "post_reaction": {
              type: :array, 'x-nullable': true,
              items: {
                "$ref": '#/definitions/PostReactionJson'
              }
            },
            "global": {
              type: :boolean
            },
            "starts_at": {
              type: :string,
              'x-nullable': true,
              "format": 'date-time'
            },
            "ends_at": {
              type: :string,
              'x-nullable': true,
              "format": 'date-time'
            },
            "repost_interval": {
              type: :integer
            },
            "status": {
              type: :string
            },
            "priority": {
              type: :integer
            },
            "recommended": {
              type: :boolean
            },
            "notify_followers": {
              type: :boolean
            },
            "comment_count": {
              type: :integer
            },
            "category": {
              type: :object,
              'x-nullable': true,
              properties: {
                "id": {type: :integer},
                "name": {
                  type: :string
                },
                "color": {
                  type: :string
                },
                "role": {
                  type: :string
                }
              }
            },
            "tags": {
              type: :array,
              items: {
                "$ref": '#/definitions/TagJson'
              }
            }
          },
          description: 'Post Response'
        },
        "TagJson": {
          type: :object,
          properties: {
            "name": {
              type: :string
            }
          },
          description: 'Tag Response'
        },
        "CategoryJson": {
          type: :object,
          properties: {
            "id": {
              type: :integer
            },
            "name": {
              type: :string
            },
            "product_id": {type: :integer},
            "color": {type: :string},
            "role": {type: :string},
            "posts": {
              type: :array, items: {"$ref": '#/definitions/PostJson'}
            }
          },
          description: 'Category Reponse'
        },
        ReferralCode: {
          type: :object,
          properties: {
            person_id: {type: :integer},
            unique_code: {type: :string}
          }
        },
        CategoryArray: {
          type: :object,
          properties: {
            categories: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  category: {"$ref": '#/definitions/CategoryJson'}
                }
              }
            }
          }
        },
        personMini: {
          type: :object,
          properties: {
            id: {type: :string},
            username: {type: :string},
            picture_url: {type: :string, 'x-nullable': true},
            designation: {type: :string, 'x-nullable': true},
            facebook_picture_url: {type: :string, 'x-nullable': true},
            badge_points: {type: :integer}
          }
        },
        MiniPeopleArray: {
          type: :object,
          properties: {
            people: {
              type: :array,
              items: {'$ref' => '#/definitions/personMini'}
            }
          }
        },
        CertcoursePageArray: {
          type: :object,
          properties: {
            certcourse_pages: {
              type: :array,
              items: {"$ref": '#/definitions/CertcoursePageJson'}
            }
          }
        },
        CertcoursePageJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            course_id: {type: :integer},
            order: {type: :integer},
            content_type: {type: :string},
            timer: {type: :integer},
            media_content_type: {type: :string},
            media_url: {type: :string},
            media_url_large: {type: :string},
            background_color_hex: {type: :string},
            is_passed: {type: :boolean}
          }
        },
        CertificatesArray: {
          type: :object,
          properties: {
            certificates: {
              type: :array,
              items: {"$ref": '#/definitions/CertificateJson'}
            }
          }
        },
        CertificateJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            order: {type: :integer},
            long_name: {type: :string},
            short_name: {type: :string},
            description: {type: :string},
            color_hex: {type: :string},
            chat_room_id: {type: :integer, 'x-nullable': true},
            sku_android: {type: :string},
            sku_ios: {type: :string},
            is_free: {type: :boolean},
            is_issuable: {type: :boolean},
            is_completed: {type: :boolean},
            is_purchased: {type: :boolean},
            certificate_image_url: {type: :string, 'x-nullable': true},
            issued_certificate_image_url: {type: :string, 'x-nullable': true}
          },
          description: 'Certificate Response'
        },
        ClientCertcourseQuizzArray: {
          type: :object,
          properties: {
            quizzes: {
              type: :array,
              items: {"$ref": '#/definitions/ClientCertcourseQuizzJson'}
            }
          }
        },
        ClientCertcourseQuizzJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            is_optional: {type: :boolean},
            is_survey: {type: :boolean},
            quiz_text: {type: :string},
            certcourse_pages_count: {type: :integer},
            page_order: {type: :integer},
            no_of_failed_attempts: {type: :integer},
            answer_text: {type: :string},
            is_correct: {type: :boolean}
          }
        },
        ClientCertcoursesArray: {
          type: :object,
          properties: {
            certcourses: {
              type: :array,
              items: {"$ref": '#/definitions/ClientCertcoursesJson'}
            }
          }
        },
        Certificate: {
          type: :object,
          properties: {
            id: {type: :integer},
            order: {type: :integer},
            long_name: {type: :string},
            short_name: {type: :string},
            description: {type: :string},
            color_hex: {type: :string},
            chat_room_id: {type: :integer},
            sku_android: {type: :string},
            sku_ios: {type: :string},
            is_free: {type: :boolean},
            is_issuable: {type: :boolean},
            is_completed: {type: :boolean},
            is_purchased: {type: :boolean},
            certificate_image_url: {type: :string, 'x-nullable': true},
            issued_certificate_image_url: {type: :string, 'x-nullable': true}
          }
        },
        CertificateWishlist: {
          type: :object,
          properties: {
            wishlist: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: {type: :integer},
                  certificate: {
                    type: :object,
                    "$ref": '#/definitions/Certificate'
                  }
                }
              }
            }
          }
        },
        ClientCertcoursesJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            certificate_id: {type: :integer},
            order: {type: :integer},
            long_name: {type: :string},
            short_name: {type: :string},
            description: {type: :string},
            duration: {type: :integer},
            color_hex: {type: :string},
            page_count: {type: :integer},
            is_completed: {type: :boolean},
            last_completed_page_id: {type: :integer, 'x-nullable': true},
            copyright_text: {type: :string},
            is_started: {type: :boolean},
            last_completed_page_order: {type: :integer}
          }
        },
        ClientCertificateDownloadJson: {
          type: :object,
          properties: {
            certificate: {
              type: :object,
              properties: {
                image_url: {type: :string}
              }
            }
          }
        },
        PersonCertcourseCreateJson: {
          type: :object,
          properties: {
            certcourse_id: {type: :integer},
            last_completed_page_id: {type: :integer}
          }
        },

        "CertificateObject": {
          type: :object,
          properties: {
            "certificate": {
              "$ref": '#/definitions/CertificateJson'
            }
          }
        },
        EventsArray: {
          type: :object,
          properties: {
            events: {
              type: :array,
              items: {"$ref": '#/definitions/EventJson'}
            }
          }
        },
        CertcourseArray: {
          type: :object,
          properties: {
            certcourses: {
              type: :array,
              items: {"$ref": '#/definitions/CertcourseJson'},
            },
          },
        },

        EventCheckinArray: {
          type: :object,
          properties: {
            event_checkins: {
              type: :array,
              items: {"$ref": '#/definitions/EventCheckinJson'},
            },
          },
        },
        EventCheckinJson: {
          type: :object,
          properties: {
            id: {type: :string},
            checkin_at: {type: :string, format: "date-time"},
            person: { "$ref": '#/definitions/personMini' }
          }
        },
        EventJson: {
          type: :object,
          "properties": {
            id: {type: :string},
            name: {type: :string},
            description: {type: :string},
            starts_at: {type: :string, format: "date-time"},
            ends_at: {type: :string,  format: "date-time"},
            ticket_url: {type: :string},
            place_identifier: {type: :string},
          },
          description: "Event Response",
        },
        CertcourseJson: {
          type: :object,
          properties: {
            id: {type: :integer},
            certificate_id: {type: :integer},
            order: {type: :integer},
            long_name: {type: :string},
            short_name: {type: :string},
            description: {type: :string},
            duration: {type: :integer},
            color_hex: {type: :string},
            page_count: {type: :integer},
            is_completed: {type: :boolean},
            last_completed_page_id: {type: :integer, 'x-nullable': true},
            copyright_text: {type: :string},
            is_started: {type: :boolean},
          },
        },
        QuestObject: {
          type: :object,
          properties: {
            quest: {"$ref": "#/definitions/QuestJson"},
          }
        },
        QuestsArray: {
          "type": "object",
          "properties": {
            "quests": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "quest": {
                    "$ref": "#/definitions/QuestJson"
                  }
                }
              }
            }
          }
        },

        QuestJson: {
          "type": :object,
          "properties": {
            "id": {
              "type": "string"
            },
            "product_id": {
              "type": "string"
            },
            "event_id": {
              "type": "string"
            },
            "name": {
              "type": "string"
            },
            "internal_name": {
              "type": "string"
            },
            "description": {
              "type": "string"
            },
            "picture_url": {
              "type": "string", 'x-nullable': true
            },
            "picture_width": {
              "type": "integer", 'x-nullable': true
            },
            "picture_height": {
              "type": "integer", 'x-nullable': true
            },
            "status": {
              "type": "string"
            },
            "starts_at": {
              "type": "string",
              "format": "date-time"
            },
            "ends_at": {
              "type": "string",
              "format": "date-time", 'x-nullable': true
            },
            "create_time": {
              "type": "string",
              "format": "date-time", 'x-nullable': true
            },
            "steps": {
              "type": "array",
              'x-nullable': true,
              "items": {
                "$ref": "#/definitions/StepJson"
              }
            }
          },
          "description": "Quest Response"
        },
        "StepJson": {
          "type": "object",
          "properties": {
            "id": {
              "type": "integer"
            },
            "quest_id": {
              "type": "integer"
            },
            "unlocks": {
              "type": "array",
              "items": {
                "type": "integer"
              }
            },
            "display": {
              "type": "string"
            },
            "status": {
              "type": "string"
            },
            "quest_activities": {
              "type": "array",
              "items": {
                "$ref": "#/definitions/QuestActivityJson"
              }
            },
            "delay_unlock": {
              "type": "integer"
            },
            "unlocks_at": {
              "type": "string",
              "format": "date-time"
            }
          },
          "description": "Step Response"
        },

        "QuestActivityJson": {
          "type": "object",
          "properties": {
            "id": {
              "type": "integer"
            },
            "quest_id": {
              "type": "integer"
            },
            "step_id": {
              "type": "integer"
            },
            "description": {
              "type": "string"
            },
            "hint": {
              "type": "string"
            },
            "picture_url": {
              "type": "string"
            },
            "picture_width": {
              "type": "integer"
            },
            "picture_height": {
              "type": "integer"
            },
            "completed": {
              "type": "boolean"
            },
            "requirements": {
              "type": "array",
              "items": {
                "$ref": "#/definitions/ActivityTypeJson"
              }
            },
            "deleted": {
              "type": "boolean"
            },
            "step": {
              "$ref": "#/definitions/StepJson"
            },
            "created_at": {
              "type": "string",
              "format": "date-time"
            }
          },
          "description": "Quest Activity Response"
        },
        "ActivityTypeJson": {
          "type": "object",
          "properties": {
            "id": {
              "type": "integer"
            },
            "atype": {
              "type": "string"
            },
            "activity_id": {
              "type": "integer"
            },
            "value": {
              "type": "object",
              "properties": {
                "id": {
                  "type": "string"
                },
                "description": {
                  "type": "string"
                }
              }
            }
          },
          "description": "Activity Type Reponse"
        },
      },

      # definitions: {
      #   certificate_information: {
      #     type: :object,
      #     properties: {
      #       certificate: {
      #         type: :object,
      #         properties: {
      #           name: {type: :string},
      #           issued_date: {type: :string, format: "date", 'x-nullable': true},
      #           certificate_image_url: {type: :string},
      #         },
      #       },
      #     },
      #   },
      #   CategoryArray: {
      #     type: :object,
      #     properties: {
      #       categories: {
      #         type: :array,
      #         items: {
      #           type: :object,
      #           properties: {
      #             category: { "$ref": "#/definitions/CategoryJson" }
      #           }
      #         }
      #       }
      #     }
      #   },
      #   CategoryJson: {
      #     type: :object,
      #     properties: {
      #       id: {type: :string},
      #       name: {type: :string},
      #       product_id: {type: :string},
      #       color: {type: :string},
      #       role: {type: :string},
      #       posts: {
      #         type: :array,
      #         items: {
      #           "$ref": "#/definitions/PostJson"
      #         }
      #       }
      #     },
      #     "description": "Category Reponse"
      #   },
      #   PostArray: {
      #     type: :object,
      #     properties: {
      #       posts: {
      #         type: :array,
      #         items: {
      #           "$ref": "#/definitions/PostJson"
      #         }
      #       }
      #     }
      #   },
      #   "PostJson": {
      #     type: :object,
      #     properties: {
      #       id: { type: :integer },
      #       create_time: { type: :string, format: "date-time" },
      #       body: {type: :string },
      #       picture_url: { type: :string},
      #       audio_url: { type: :string},
      #       audio_size: { type: :integer },
      #       audio_content_type: { type: :string},
      #       person: { "$ref": "#/components/schemas/public_person" },
      #       post_reaction_counts: { type: :integer },
      #       post_reaction: { "$ref": "#/components/schemas/PostReactionJson" },
      #       global: { type: :boolean },
      #       starts_at: { type: :string, format: "date-time" },
      #       "ends_at": { type: :string, format: "date-time" },
      #       "repost_interval": {type: :integer },
      #       "status":{ type: :string},
      #       "priority": { type: :integer },
      #       "recommended": {
      #           type: :boolean
      #       },
      #       "notify_followers": {
      #           type: :boolean
      #       },
      #           "comment_count": { type: :integer },
      #           category: { "$ref": "#/definitions/CategoryJson" },
      #           "tags": {
      #               "type": "array",
      #               "items": {
      #                   "$ref": "#/components/schemas/TagJson"
      #               }
      #           }
      #       },
      #       "description": "Post Response"
      #   },
      #
      #   BadgeActionsPending: {
      #     type: :object,
      #     properties: {
      #       pending_badge: {
      #         type: :object,
      #         properties: {
      #           badge_action_count: { type: :integer },
      #           badge: { "$ref": "#/definitions/BadgeJson" }
      #         }
      #       },
      #       badges_awarded: {
      #         type: :array,
      #         items: { "$ref": "#/definitions/BadgeJson" }
      #       }
      #     }
      #   },
      #   public_person: {
      #     type: :object,
      #     properties: {
      #       id: {type: :string},
      #       username: {type: :string},
      #       name: {type: :string, 'x-nullable': true},
      #       email: {type: :string},
      #       gender: {type: :string},
      #       city: {type: :string, 'x-nullable': true},
      #       country_code: {type: :string, 'x-nullable': true},
      #       birthdate: {type: :string, format: "date", 'x-nullable': true},
      #       biography: {type: :string, 'x-nullable': true},
      #       picture_url: {type: :string, 'x-nullable': true},
      #       product_account: {type: :boolean},
      #       recommended: {type: :boolean},
      #       chat_banned: {type: :boolean},
      #       tester: {type: :boolean},
      #       terminated: {type: :boolean},
      #       terminated_reason: {type: :string, 'x-nullable': true},
      #       designation: {type: :string, 'x-nullable': true},
      #       role: {type: :string},
      #       do_not_message_me: {type: :boolean},
      #       pin_messages_from: {type: :boolean},
      #       auto_follow: {type: :boolean},
      #       num_followers: {type: :integer},
      #       num_following: {type: :integer},
      #       facebookid: {type: :string, 'x-nullable': true},
      #       facebook_picture_url: {type: :string, 'x-nullable': true},
      #       badge_points: {type: :integer},
      #       level: {type: :integer, 'x-nullable': true},
      #       created_at: {type: :string, format: "date-time"},
      #       updated_at: {type: :string, format: "date-time"},
      #       following_id: {type: :integer, 'x-nullable': true},
      #       relationships: {
      #         type: :array,
      #         items: {
      #           "$ref" => "#/definitions/relationships",
      #         },
      #       },
      #     },
      #   },
      #   relationships: {
      #     type: :object,
      #     properties: {
      #       id: {type: :string},
      #       status: {type: :string},
      #       requested_by: {:type => :object, "$ref" => "#/definitions/public_person"},
      #       requested_to: {:type => :object, "$ref" => "#/definitions/public_person"},
      #       created_at: {type: :string, format: "date-time"},
      #       updated_at: {type: :string, format: "date-time"},
      #     },
      #   },
      #   people: {
      #     type: :array,
      #     items: {
      #       "$ref" => "#/definitions/public_person",
      #     },
      #   },
      #   session_jwt: {
      #     type: :object,
      #     properties: {
      #       person: {
      #         type: :object,
      #         properties: {
      #           id: {type: :string},
      #           username: {type: :string},
      #           name: {type: :string, 'x-nullable': true},
      #           gender: {type: :string},
      #           city: {type: :string, 'x-nullable': true},
      #           country_code: {type: :string, 'x-nullable': true},
      #           birthdate: {type: :string, format: "date", 'x-nullable': true},
      #           biography: {type: :string, 'x-nullable': true},
      #           picture_url: {type: :string, 'x-nullable': true},
      #           product_account: {type: :boolean},
      #           recommended: {type: :boolean},
      #           chat_banned: {type: :boolean},
      #           tester: {type: :boolean},
      #           terminated: {type: :boolean},
      #           terminated_reason: {type: :string, 'x-nullable': true},
      #           designation: {type: :string, 'x-nullable': true},
      #           role: {type: :string},
      #           do_not_message_me: {type: :boolean},
      #           pin_messages_from: {type: :boolean},
      #           auto_follow: {type: :boolean},
      #           num_followers: {type: :integer},
      #           num_following: {type: :integer},
      #           facebookid: {type: :string, 'x-nullable': true},
      #           facebook_picture_url: {type: :string, 'x-nullable': true},
      #           badge_points: {type: :integer},
      #           level: {type: :integer, 'x-nullable': true},
      #           created_at: {type: :string, format: "date-time"},
      #           updated_at: {type: :string, format: "date-time"},
      #           following_id: {type: :integer, 'x-nullable': true},
      #           email: {type: :string},
      #           product: {
      #             type: :object,
      #             properties: {
      #               id: {type: :integer},
      #               internal_name: {type: :string},
      #               name: {type: :string},
      #             },
      #           },
      #           level_progress: {type: :integer, 'x-nullable': true},
      #           rewards: {type: :string, 'x-nullable': true},
      #           blocked_people: {type: :integer, 'x-nullable': true},
      #           permissions: {
      #             type: :object,
      #           },
      #           pin_messages_to: {type: :integer, 'x-nullable': true},
      #           token: {type: :string},
      #         },
      #       },
      #     },
      #   },
      #   person_mini: {
      #     type: :object,
      #     properties: {
      #       id: {type: :string},
      #       username: {type: :string},
      #       picture_url: {type: :string},
      #       designation: {type: :string},
      #       facebook_picture_url: {type: :string},
      #       badge_points: {type: :integer},
      #     },
      #   },
      #   trivia_user_subscribed: {
      #     type: :object,
      #     properties: {
      #       game_id: {type: :integer},
      #       person_id: {type: :integer},
      #       subscribed: {type: :boolean},
      #       user_enroled: {type: :boolean},
      #       user_notification: {type: :boolean},
      #     },
      #   },
      #   trivia_game_prize: {
      #     type: :object,
      #     properties: {
      #       id: {type: :integer},
      #       game_id: {type: :integer},
      #       position: {type: :integer},
      #       photo_url: {type: :string},
      #       description: {type: :string},
      #     },
      #   },
      #   trivia_round: {
      #     type: :object,
      #     properties: {
      #       id: {type: :integer},
      #       game_id: {type: :integer},
      #       start_date: {type: :integer},
      #       end_date: {type: :integer},
      #       question_size: {type: :integer},
      #       complexity: {type: :integer},
      #       status: {type: :string},
      #     },
      #   },
      #   trivia_round_list: {
      #     type: :object,
      #     properties: {
      #       rounds: {
      #         type: :array,
      #         items: {
      #           "$ref" => "#/definitions/trivia_round",
      #         },
      #       },
      #     },
      #   },
      #
      #   trivia_game_prize_list: {
      #     type: :object,
      #     properties: {
      #       prizes: {
      #         type: :array,
      #         items: {
      #           "$ref" => "#/definitions/trivia_game_prize",
      #         },
      #       },
      #     },
      #   },
      #
      #   trivia_games_leaderboard_list: {
      #     type: :object,
      #     properties: {
      #       leaderboard: {
      #         type: :array,
      #         items: {
      #           "$ref" => "#/definitions/trivia_games_leaderboard",
      #         },
      #       },
      #     },
      #     required: ["games"],
      #   },
      #   trivia_games_leaderboard: {
      #     type: :object,
      #     properties: {
      #       id: {type: :integer},
      #       game_id: {type: :integer},
      #       points: {type: :integer},
      #       position: {type: :integer},
      #       average_time: {type: :integer},
      #       person: {:type => :object, "$ref" => "#/definitions/person_mini"},
      #     },
      #   },
      #   trivia_rounds_leaderboard_list: {
      #     type: :object,
      #     properties: {
      #       leaderboard: {
      #         type: :array,
      #         items: {
      #           "$ref" => "#/definitions/trivia_rounds_leaderboard",
      #         },
      #       },
      #     },
      #     required: ["games"],
      #   },
      #   trivia_rounds_leaderboard: {
      #     type: :object,
      #     properties: {
      #       id: {type: :integer},
      #       round_id: {type: :integer},
      #       points: {type: :integer},
      #       position: {type: :integer},
      #       average_time: {type: :integer},
      #       person: {:type => :object, "$ref" => "#/definitions/person_mini"},
      #     },
      #   },
      #   trivia_games_list: {
      #     type: :object,
      #     properties: {
      #       games: {
      #         type: :array,
      #         items: {
      #           "$ref" => "#/definitions/trivia_game",
      #         },
      #       },
      #     },
      #     required: ["games"],
      #   },
      #   trivia_game: {
      #     type: :object,
      #     properties: {
      #       id: {type: :integer},
      #       start_date: {type: :integer},
      #       end_date: {type: :integer},
      #       long_name: {type: :string},
      #       short_name: {type: :string},
      #       description: {type: :string},
      #       round_count: {type: :integer},
      #       question_count: {type: :integer},
      #       leaderboard_size: {type: :integer},
      #       prize_count: {type: :integer},
      #       room_id: {type: :integer},
      #       status: {type: :string},
      #       picture: {type: :string},
      #       user_enroled: {type: :boolean},
      #       user_notification: {type: :boolean},
      #     },
      #     required: ["trivia_game_id"],
      #   },
      #   SuccessMessage: {
      #     type: :object,
      #     properties: {
      #        message: { type: :string }
      #     }
      #   },
      #   ErrorMessage: {
      #     type: :object,
      #     properties: {
      #        message: { type: :string }
      #     }
      #   },
      #   FollowersArray: {
      #     type: :object,
      #     properties: {
      #       followers: {
      #         type: :array,
      #         items: {
      #           type: :object,
      #           properties: {
      #             badge: { "$ref": "#/definitions/FollowingObject" }
      #           }
      #         }
      #       }
      #     }
      #   },
      #   FollowingObject: {
      #     type: :object,
      #     properties: {
      #       following: { "$ref": "#/definitions/FollowingJson" }
      #     }
      #   },
      #   FollowingJson: {
      #     type: :object,
      #     "properties": {
      #       id: { type: :string },
      #       follower: { "$ref": "#/definitions/public_person" },
      #       followed: { "$ref": "#/definitions/public_person" }
      #     },
      #     "description": "Following Response"
      #   },
      #
      #   BadgeJson: {
      #     type: :object,
      #     properties: {
      #       id: {type: :string},
      #       "name": {type: :string},
      #       "internal_name": {type: :string},
      #       "description": {type: :string,  'x-nullable': true},
      #       "picture_url": {type: :string},
      #       action_requirement: {type: :integer},
      #       point_value: {type: :integer},
      #     },
      #     "description": "Badge Response"
      #   },
      #   BadgesArray: {
      #     type: :object,
      #     properties: {
      #       badges: {
      #         type: :array,
      #         items: {
      #           type: :object,
      #           properties: {
      #             badge: { "$ref": "#/definitions/BadgeJson" }
      #           }
      #         }
      #       }
      #     }
      #   }
      # },
    },
  }

  v1file = Rails.root.join('doc', 'open_api', 'V1.json')
  v2file = Rails.root.join('doc', 'open_api', 'V2.json')
  v3file = Rails.root.join('doc', 'open_api', 'V3.json')
  config.swagger_docs['v1/swagger.json'] = JSON.parse(File.read(v1file))
  config.swagger_docs['v2/swagger.json'] = JSON.parse(File.read(v2file))
  config.swagger_docs['v3/swagger.json'] = JSON.parse(File.read(v3file))
end
