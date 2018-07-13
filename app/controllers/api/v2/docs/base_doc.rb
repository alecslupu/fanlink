class Api::V2::Docs::BaseDoc < ApiDoc
  route_base 'api/v2/base'
  components do
    api_key :SessionCookie, type: 'apiKey', field: '_fanlink_session', in: 'cookie'
    # schema :BadgeAction => [{}]
    schema :Badge => [
      {
        :id => {type: Integer},
        :name => {type: String},
        :internal_name => {type: String},
        :description => {type: String},
        :picture_url => {type: String},
        :action_requirement => {type: Integer},
        :point_value => {type: Integer}
      },
      desc: 'Badge Object'
    ]
    schema :Block => [
      {
        :id => { type: Integer },
        :blocker_id => { type: Integer },
        :blocked_id => { type: Integer }
      },
      desc: "Block object"
    ]
    schema :Event => [
      {
        :id => { type: Integer },
        :name => { type: String },
        :description => { type: String },
        :starts_at => { type: DateTime},
        :ends_at => { type: DateTime },
        :ticket_url => { type: String },
        :place_identifier => { type: String }
      },
      desc: 'Event Object'
    ]
    schema :Following => [
      {
        :id => { type: Integer },
        :follower => :Person,
        :followed => :Person
      },
      desc: 'Following Object'
    ]
    schema :Level => [
      {
        :id => { type: Integer },
        :name => { type: String },
        :internal_name => { type: String },
        :description => { type: String },
        :points => { type: Integer },
        :picture_url => { type: String }
      },
      desc: 'Level Object'
    ]
    schema :Merchandise => [
      {
        :id => { type: Integer },
        :name => { type: String },
        :description => { type: String },
        :price => { type: Integer },
        :purchase_url => { type: String },
        :picture_url => { type: String },
        :available => { type: Boolean },
        :priority => { type: Integer}
      },
      desc: 'Merchandise Object'
    ]
    schema :MessageReport => [
      {
        :id => { type: Integer },
        :created_at => { type: DateTime },
        :updated_at => { type: DateTime },
        :message_id => { type: Integer },
        :poster => { type: String },
        :reporter => { type: String },
        :reason => { type: String },
        :status => { type: String }
      },
      desc: 'Message Report Object'
    ]
    schema :Mention => [
      {
        :id => { type: Integer },
        :person_id => { type: Integer },
        :location => { type: Integer },
        :length => { type: Integer }
      },
      desc: 'Notification Type ID Object'
    ]
    schema :Message => [
      {
        :id => { type: Integer },
        :create_time => { type: DateTime },
        :body => { type: String },
        :picture_url => { type: String },
        :audio_url => { type: String },
        :audio_size => { type: String },
        :audio_content_type => { type: String },
        :person => :Person,
        :mentions => :Mention
      },
      desc: 'Message Object'
    ]
    schema :MessageList => [
      {
        :id => { type: Integer },
        :person_id => { type: Integer },
        :room_id => { type: Integer },
        :body => { type: String },
        :hidden => { type: Boolean },
        :picture_url => { type: String },
        :created_at => { type: DateTime},
        :updated_at => { type: DateTime},
      },
      desc: 'Message Object'
    ]
    schema :NotificationDeviceId => [
      {
        :id => { type: Integer },
      },
      desc: 'Notification Type ID Object'
    ]
    schema :Person => [
      {
        :id => { type: Integer },
        :username => { type: String },
        :name => { type: String },
        :gender => { type: String },
        :city => { type: String },
        :biography => { type: String },
        :country_code => { type: String },
        :birthdate => { type: String },
        :picture_url => { type: String },
        :product_account => { type: Boolean },
        :recommended => { type: Boolean },
        :chat_banned => { type: Boolean },
        :designation => { type: String },
        :following_id => { type: Integer },
        :relationships => [
          :relationship => :Relationship
        ],
        :badge_points => { type: Integer },
        :role => { type: String },
        :level => { type: String },
        :do_not_message_me => { type: Boolean },
        :pin_messages_from => { type: Boolean },
        :auto_follow => { type: Boolean },
        :num_followers => { type: Integer },
        :num_following => { type: Integer },
        :facebookid => { type: Integer },
        :facebook_picture_url => { type: String },
        :created_at => { type: DateTime},
        :updated_at => { type: DateTime}
      },
      desc: 'Person Object'
    ]
    schema :PersonPrivate => [
      {
        :id => { type: Integer },
        :username => { type: String },
        :name => { type: String },
        :gender => { type: String },
        :city => { type: String },
        :biography => { type: String },
        :country_code => { type: String },
        :birthdate => { type: String },
        :picture_url => { type: String },
        :product_account => { type: Boolean },
        :recommended => { type: Boolean },
        :chat_banned => { type: Boolean },
        :designation => { type: String },
        :following_id => { type: Integer },
        :relationships => [
          :relationship => :Relationship
        ],
        :badge_points => { type: Integer },
        :role => { type: String },
        :level => { type: String },
        :do_not_message_me => { type: Boolean },
        :pin_messages_from => { type: Boolean },
        :auto_follow => { type: Boolean },
        :num_followers => { type: Integer },
        :num_following => { type: Integer },
        :facebookid => { type: Integer },
        :facebook_picture_url => { type: String },
        :created_at => { type: DateTime},
        :updated_at => { type: DateTime},
        :email => { type: String },
        :product => {
          :id => { type: Integer },
          :name => { type: String },
          :internal_name => { type: String }
        }
      },
      desc: 'Private Person Object'
    ]
    schema :PostCommentReport => [
      {
        :id => { type: Integer },
        :created_at => { type: DateTime },
        :post_comment_id => { type: Integer },
        :commenter => { type: String },
        :reporter => { type: String},
        :reason => { type: String },
        :status => { type: String }
      },
      desc: 'Post Comment Report Object'
    ]
    schema :PostComment => [
      {
        :id => { type: Integer },
        :create_time => { type: DateTime },
        :body => { type: String },
        :mentions => [
          :mention => :Mention
        ],
        :person => :Person
      },
      desc: 'Post Comment Object'
    ]
    schema :PostCommentList => [
      {
        :id => { type: Integer },
        :person_id => { type: Integer },
        :post_id => { type: Integer },
        :body => { type: String },
        :hidden => { type: Boolean },
        :created_at => { type: DateTime },
        :updated_at => { type: DateTime },
        :mentions => [
          :mention => :Mention
        ]
      },
      desc: 'Post Comment Object'
    ]
    schema :PostReaction => [
      {
        :id => { type: Integer },
        :post_id => { type: Integer },
        :person_id => { type: Integer },
        :reaction => { type: String }
      },
      desc: 'Post Reaction Object'
    ]
    schema :PostReport => [
      {
        :id => { type: Integer },
        :created_at => { type: DateTime },
        :post_id => { type: Integer },
        :poster => { type: String },
        :reporter => { type: String },
        :reason =>  { type: String },
        :status => { type: String }
      },
      desc: 'Post Report Object'
    ]
    schema :Post => [
      {
        :id => { type: Integer },
        :create_time => { type: DateTime },
        :body => {  type: String },
        :picture_url => { type: String },
        :audio_url => { type: String },
        :audio_size => { type: Integer},
        :audio_content_type => { type: String },
        :person => :Person,
        :post_reaction_counts => { type: Integer },
        :post_reaction => :PostReaction,
        :global => { type: Boolean },
        :starts_at => { type: DateTime },
        :ends_at => { type: DateTime },
        :repost_interval => { type: Integer },
        :status => { type: String },
        :priority => { type: Integer },
        :recommended => { type: Boolean },
        :notify_followers => { type: Boolean },
        :comment_count => { type: Integer },
        :category => {
          :id => { type: Integer },
          :name => { type: String },
          :color => { type: String },
          :role => { type: String }
        },
        :tags => [
          :tag => :Tag
        ]

      },
      desc: 'Post Object'
    ]
    schema :PostShare => [
      {
        :body => {  type: String },
        :picture_url => { type: String },
        :person => {
          :username => { type: String },
          :picture_url => { type: String}
        }
      },
      desc: 'Shared Post Object'
    ]
    schema :PostList => [
      {
        :id => { type: Integer },
        :person => :Person,
        :body => {  type: String },
        :picture_url => { type: String },
        :global => { type: Boolean },
        :starts_at => { type: DateTime },
        :ends_at => { type: DateTime },
        :repost_interval => { type: Integer },
        :status => { type: String },
        :priority => { type: Integer },
        :recommended => { type: Boolean },
        :notify_followers => { type: Boolean },
        :comment_count => { type: Integer },
        :category => {
          :id => { type: Integer },
          :name => { type: String },
          :color => { type: String },
          :role => { type: String }
        },
        :tags => [
          :tag => :Tag
        ]
      },
      desc: 'List Post Object'
    ]
    schema :RecommendedPeople => :Person
    schema :Relationship => [
      {
        :id => { type: Integer },
        :status => { type: String },
        :create_time => { type: DateTime },
        :update_time => { type: DateTime },
        :requested_by => :Person,
        :requested_to => :Person
      },
      desc: 'Relationship Object'
    ]
    schema :RoomMembership => [
      {
        :id => { type: Integer },
      },
      desc: 'Room Membership Object'
    ]
    schema :Room => [
      {
        :id => { type: Integer },
        :name => { type: String },
        :description => { type: String },
        :owned => { type: Boolean },
        :picture_url => { type: String },
        :public => { type: Boolean },
        :members => [
          :member => :Person
        ]
      },
      desc: 'Room Object'
    ]
    schema :Session => [
      {
        :person => :PersonPrivate
      },
      desc: 'Session Object'
    ]
    schema :Tag => [
      {
        :name => { type: String },
      },
      desc: ''
    ]
    # schema :Template => [
    #   {
    #     :id => { type: Integer },
    #   },
    #   desc: ''
    # ]

# Crud Template

  # components do

  # end

  # api :index, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :create, '' do
  #   desc ''
  #   query :, , desc: ''
  #   form! data: {
  #     :! => {
  #     }
  #   }
  #   response_ref 200 => :
  # end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :update, '' do
  #   desc ''
  #   form! data: {
  #     :! => {

  #     }
  #   }
  #   response_ref 200 => :
  # end

  # api :destroy, '' do
  #   desc ''
  #   response_ref 200 => :OK
  # end

  # resp :NotificationDeviceIds200 => ['HTTP/1.1 200 Ok', :json, data:{

  # }]
  # resp :PasswordResets200 => ['HTTP/1.1 200 Ok', :json, data:{

  # }]
    resp :OK => ['HTTP/1.1 200 Ok']
  end
end
