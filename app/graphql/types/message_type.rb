module Types
  class MessageType < Types::BaseObject
    graphql_name "Post"
    description "User Created Posts"
    field :id, ID, null: false
    field :body, String, null: true
    field :global, Boolean, null: true
    field :status, String, null: true
    field :recommended, Boolean, null: true
    field :notify_followers, Boolean, null: true
    field :priority, Integer, null: false
    field :create_time, String, null: false
    field :picture_url, String, null: true
    field :audio_url, String, null: true
    field :audio_size, Integer, null: true
    field :audio_content_type, String, null: true
    field :video_url, String, null: true
    field :comment_count, Integer, null: false
    field :total, Integer, null: false

    def comment_count
      object.post_comments_count
    end

    def total
      object.size
    end

    def create_time
      object.created_at.to_s
    end
  end
end