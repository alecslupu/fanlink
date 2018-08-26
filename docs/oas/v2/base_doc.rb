class Api::V2::BaseDoc < ApiDoc
  route_base "api/v2/base"
  components do
    api_key :SessionCookie, type: "apiKey", field: "_fanlink_session", in: "cookie"
    # schema :BadgeAction => [{}]
    schema ActivityTypeJson: [
      {
        id: { type: Integer },
        atype: { type: String },
        activity_id: { type: Integer },
        value: {
          id: { type: String },
          description: { type: String }
        }
      },

      desc: "Activity Type Object"
    ]
    schema BadgeJson: [
      {
        id: { type: Integer },
        name: { type: String },
        internal_name: { type: String },
        description: { type: String },
        picture_url: { type: String },
        action_requirement: { type: Integer },
        point_value: { type: Integer }
      },

      desc: "Badge Response"
    ]
    schema BlockJson: [
      {
        id: { type: Integer },
        blocker_id: { type: Integer },
        blocked_id: { type: Integer }
      },

      desc: "Block object"
    ]
    schema CategoryJson: [
      {
        id: { type: Integer },
        name: { type: String },
        product_id: { type: Integer },
        color: { type: String },
        role: { type: String },
        posts: [
          post: :Post
        ]
      },

      desc: ""
    ]
    schema EventJson: [
      {
        id: { type: Integer },
        name: { type: String },
        description: { type: String },
        starts_at: { type: DateTime },
        ends_at: { type: DateTime },
        ticket_url: { type: String },
        place_identifier: { type: String }
      },

      desc: "Event Response"
    ]
    schema FollowingJson: [
      {
        id: { type: Integer },
        follower: :PersonJson,
        followed: :PersonJson
      },

      desc: "Following Response"
    ]
    schema LevelJson: [
      {
        id: { type: Integer },
        name: { type: String },
        internal_name: { type: String },
        description: { type: String },
        points: { type: Integer },
        picture_url: { type: String }
      },

      desc: "Level Response"
    ]
    schema MerchandiseJson: [
      {
        id: { type: Integer },
        name: { type: String },
        description: { type: String },
        price: { type: Integer },
        purchase_url: { type: String },
        picture_url: { type: String },
        available: { type: Boolean },
        priority: { type: Integer }
      },

      desc: "Merchandise Response"
    ]
    schema MessageReportJson: [
      {
        id: { type: Integer },
        created_at: { type: DateTime },
        updated_at: { type: DateTime },
        message_id: { type: Integer },
        poster: { type: String },
        reporter: { type: String },
        reason: { type: String },
        status: { type: String }
      },

      desc: "Message Report Response"
    ]
    schema MentionJson: [
      {
        id: { type: Integer },
        person_id: { type: Integer },
        location: { type: Integer },
        length: { type: Integer }
      },

      desc: "Notification Type ID Response"
    ]
    schema MessageJson: [
      {
        id: { type: Integer },
        create_time: { type: DateTime },
        body: { type: String },
        picture_url: { type: String },
        audio_url: { type: String },
        audio_size: { type: String },
        audio_content_type: { type: String },
        person: :PersonJson,
        mentions: :Mention
      },

      desc: "Message Response"
    ]
    schema MessageListJson: [
      {
        id: { type: Integer },
        person_id: { type: Integer },
        room_id: { type: Integer },
        body: { type: String },
        hidden: { type: Boolean },
        picture_url: { type: String },
        created_at: { type: DateTime },
        updated_at: { type: DateTime },
      },

      desc: "Message Response"
    ]
    schema NotificationDeviceIdJson: [
      {
        id: { type: Integer },
      },

      desc: "Notification Type ID Response"
    ]
    schema PersonJson: [
      {
        id: { type: Integer },
        username: { type: String },
        name: { type: String },
        gender: { type: String },
        city: { type: String },
        biography: { type: String },
        country_code: { type: String },
        birthdate: { type: String },
        picture_url: { type: String },
        product_account: { type: Boolean },
        recommended: { type: Boolean },
        chat_banned: { type: Boolean },
        designation: { type: String },
        following_id: { type: Integer },
        relationships: [
          relationship: :Relationship
        ],
        badge_points: { type: Integer },
        role: { type: String },
        level: { type: String },
        do_not_message_me: { type: Boolean },
        pin_messages_from: { type: Boolean },
        auto_follow: { type: Boolean },
        num_followers: { type: Integer },
        num_following: { type: Integer },
        facebookid: { type: Integer },
        facebook_picture_url: { type: String },
        created_at: { type: DateTime },
        updated_at: { type: DateTime }
      },

      desc: "Person Response"
    ]
    schema PersonPrivateJson: [
      {
        id: { type: Integer },
        username: { type: String },
        name: { type: String },
        gender: { type: String },
        city: { type: String },
        biography: { type: String },
        country_code: { type: String },
        birthdate: { type: String },
        picture_url: { type: String },
        product_account: { type: Boolean },
        recommended: { type: Boolean },
        chat_banned: { type: Boolean },
        designation: { type: String },
        following_id: { type: Integer },
        relationships: [
          relationship: :Relationship
        ],
        badge_points: { type: Integer },
        role: { type: String },
        level: { type: String },
        do_not_message_me: { type: Boolean },
        pin_messages_from: { type: Boolean },
        auto_follow: { type: Boolean },
        num_followers: { type: Integer },
        num_following: { type: Integer },
        facebookid: { type: Integer },
        facebook_picture_url: { type: String },
        created_at: { type: DateTime },
        updated_at: { type: DateTime },
        email: { type: String },
        product: {
          id: { type: Integer },
          name: { type: String },
          internal_name: { type: String }
        }
      },

      desc: "Private Person Response"
    ]
    schema PostCommentReportJson: [
      {
        id: { type: Integer },
        created_at: { type: DateTime },
        post_comment_id: { type: Integer },
        commenter: { type: String },
        reporter: { type: String },
        reason: { type: String },
        status: { type: String }
      },

      desc: "Post Comment Report Response"
    ]
    schema PostCommentJson: [
      {
        id: { type: Integer },
        create_time: { type: DateTime },
        body: { type: String },
        mentions: [
          mention: :Mention
        ],
        person: :PersonJson
      },

      desc: "Post Comment Response"
    ]
    schema PostCommentListJson: [
      {
        id: { type: Integer },
        person_id: { type: Integer },
        post_id: { type: Integer },
        body: { type: String },
        hidden: { type: Boolean },
        created_at: { type: DateTime },
        updated_at: { type: DateTime },
        mentions: [
          mention: :Mention
        ]
      },

      desc: "Post Comment Response"
    ]
    schema PostReactionJson: [
      {
        id: { type: Integer },
        post_id: { type: Integer },
        person_id: { type: Integer },
        reaction: { type: String }
      },

      desc: "Post Reaction Response"
    ]
    schema PostReportJson: [
      {
        id: { type: Integer },
        created_at: { type: DateTime },
        post_id: { type: Integer },
        poster: { type: String },
        reporter: { type: String },
        reason: { type: String },
        status: { type: String }
      },

      desc: "Post Report Response"
    ]
    schema PostJson: [
      {
        id: { type: Integer },
        create_time: { type: DateTime },
        body: {  type: String },
        picture_url: { type: String },
        audio_url: { type: String },
        audio_size: { type: Integer },
        audio_content_type: { type: String },
        person: :PersonJson,
        post_reaction_counts: { type: Integer },
        post_reaction: :PostReaction,
        global: { type: Boolean },
        starts_at: { type: DateTime },
        ends_at: { type: DateTime },
        repost_interval: { type: Integer },
        status: { type: String },
        priority: { type: Integer },
        recommended: { type: Boolean },
        notify_followers: { type: Boolean },
        comment_count: { type: Integer },
        category: {
          id: { type: Integer },
          name: { type: String },
          color: { type: String },
          role: { type: String }
        },
        tags: [
          tag: :Tag
        ]

      },

      desc: "Post Response"
    ]
    schema PostShareJson: [
      {
        body: {  type: String },
        picture_url: { type: String },
        person: {
          username: { type: String },
          picture_url: { type: String }
        }
      },

      desc: "Shared Post Response"
    ]
    schema PostListJson: [
      {
        id: { type: Integer },
        person: :PersonJson,
        body: {  type: String },
        picture_url: { type: String },
        global: { type: Boolean },
        starts_at: { type: DateTime },
        ends_at: { type: DateTime },
        repost_interval: { type: Integer },
        status: { type: String },
        priority: { type: Integer },
        recommended: { type: Boolean },
        notify_followers: { type: Boolean },
        comment_count: { type: Integer },
        category: {
          id: { type: Integer },
          name: { type: String },
          color: { type: String },
          role: { type: String }
        },
        tags: [
          tag: :Tag
        ]
      },

      desc: "List Post Response"
    ]
    schema ProductBeaconJson: [
      {
        id: { type: Integer },
        product_id: { type: Integer },
        beacon_pid: { type: String },
        uuid: { type: String },
        lower: { type: Integer },
        upper: { type: Integer },
        created_at: { type: String, format: "date-time" }
      },

      desc: "Product Beacon Response"
    ]
    schema ProductJson: [
      {
        id: { type: Integer },
        name: { type: String },
        internal_name: { type: String },
        enabled: { type: Boolean }
      },

      desc: "Product Response"
    ]
    schema QuestActivityJson: [
      {
        id: { type: Integer },
        quest_id: { type: Integer },
        step_id: { type: Integer },
        description: { type: String },
        hint: { type: String },
        picture_url: { type: String },
        picture_width: { type: Integer },
        picture_height: { type: Integer },
        completed: { type: Boolean },
        requirements: [:ActivityType],
        deleted: { type: Boolean },
        step: :Step,
        created_at: { type: String, format: "date-time" }
      },
      desc: "Quest Activity Response"
    ]
    # schema :QuestCompleted => [
    #   {
    #     :id => { type: Integer },
    #   },

    #   desc: ''
    # ]
    schema QuestCompletionJson: [
      {
        id: { type: Integer },
        person_id: { type: Integer },
        step_id: { type: Integer },
        activity_id: { type: Integer },
        status: { type: String },
        create_time: { type: String, format: "date-time" }
      },
      desc: ""
    ]
    schema QuestJson: [
      {
        id: { type: Integer },
        product_id: { type: Integer },
        event_id: { type: Integer, nullable: true },
        name: { type: String },
        internal_name: { type: String },
        description: { type: String },
        picture_url: { type: String },
        picture_width: { type: Integer },
        picture_height: { type: Integer },
        status: { type: String },
        starts_at: { type: String, format: "date-time" },
        ends_at: { type: String, format: "date-time" },
        create_time: { type: String, format: "date-time" },
        steps: [:Step]
      },
      desc: "Step Response"
    ]
    schema RecommendedPeopleJson: :Json
    schema RelationshipJson: [
      {
        id: { type: Integer },
        status: { type: String },
        create_time: { type: DateTime },
        update_time: { type: DateTime },
        requested_by: :PersonJson,
        requested_to: :PersonJson
      },

      desc: "Relationship Response"
    ]
    schema RoomMembershipJson: [
      {
        id: { type: Integer },
      },

      desc: "Room Membership Response"
    ]
    schema RoomJson: [
      {
        id: { type: Integer },
        name: { type: String },
        description: { type: String },
        owned: { type: Boolean },
        picture_url: { type: String },
        public: { type: Boolean },
        members: [
          member: :PersonJson
        ]
      },

      desc: "Room Response"
    ]
    schema SessionJson: [
      {
        person: :PersonPrivateJson
      },
      desc: "Session Response"
    ]
    schema StepJson: [
      {
        id: { type: Integer },
        quest_id: { type: Integer },
        unlocks: [Integer],
        display: { type: String },
        status: { type: String },
        quest_activities: [:QuestActivity],
        delay_unlock: { type: Integer },
        unlocks_at: { type: String, format: "date-time" }
      },

      desc: "Step Response"
    ]
    schema TagJson: [
      {
        name: { type: String },
      },

      desc: "Tag Response"
    ]
    # schema :TemplateJson => [
    #   {
    #     :id => { type: Integer },
    #   },
    #
    #   desc: ''
    # ]

    # Crud Template
    # doc_tag name: '', desc: ""
    # route_base 'api/v/'
    # components do
    #   resp :Object  => ['HTTP/1.1 200 Ok', :json, data:{
    #     : => :
    #   }]

    #   resp :Array  => ['HTTP/1.1 200 Ok', :json, data:{
    #     :s => [
    #       : => :Json
    #     ]
    #   }]

    #   body! :CreateForm, :form, data: {
    #     :! => {
    #     }
    #   }

    #   body! :UpdateForm, :form, data: {
    #     :! => {
    #     }
    #   }
    # end

    # api :index, 'Get all ' do
    #   need_auth :SessionCookie
    #   desc ''
    #   response_ref 200 => :
    # end

    # api :create, 'Create a ' do
    #   need_auth :SessionCookie
    #   desc ''
    #   query :, , desc: ''
    #   body_ref :
    #   response_ref 200 => :
    # end

    # api :show, 'Find a ' do
    #   need_auth :SessionCookie
    #   desc ''
    #   response_ref 200 => :
    # end

    # api :update, 'Update a ' do
    #   need_auth :SessionCookie
    #   desc ''
    #   body_ref :
    #   response_ref 200 => :
    # end

    # api :destroy, 'Destroy a ' do
    #   need_auth :SessionCookie
    #   desc ''
    #   response_ref 200 => :OK
    # end

    resp OK: ["HTTP/1.1 200 Ok"]
  end
end
