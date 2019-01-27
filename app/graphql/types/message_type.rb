module Types
  class MessageType < Types::BaseObject
    graphql_name "Post"
    description "User Created Posts"
    field :id, types.ID, null: false
    field :body, types.String
    field :global, !types.Boolean
    field :status, types.String
    field :recommended, !types.Boolean
    field :notify_followers, !types.Boolean

    field :picture_url, !types.String
    field :audio_url, !types.String
    field :audio_size, !types.Int
    field :audio_content_type, !types.String
    field :video_url, !types.String

  end
end