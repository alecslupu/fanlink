class PostJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246c068 @name="PostJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "create_time"=>{"type"=>"string", "format"=>"date-time"}, "body"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "audio_url"=>{"type"=>"string"}, "audio_size"=>{"type"=>"integer"}, "audio_content_type"=>{"type"=>"string"}, "person"=>{"$ref"=>"#/components/schemas/PersonJson"}, "post_reaction_counts"=>{"type"=>"integer"}, "post_reaction"=>{"$ref"=>"#/components/schemas/PostReaction"}, "global"=>{"type"=>"boolean"}, "starts_at"=>{"type"=>"string", "format"=>"date-time"}, "ends_at"=>{"type"=>"string", "format"=>"date-time"}, "repost_interval"=>{"type"=>"integer"}, "status"=>{"type"=>"string"}, "priority"=>{"type"=>"integer"}, "recommended"=>{"type"=>"boolean"}, "notify_followers"=>{"type"=>"boolean"}, "comment_count"=>{"type"=>"integer"}, "category"=>{"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "color"=>{"type"=>"string"}, "role"=>{"type"=>"string"}}}, "tags"=>{"type"=>"array", "items"=>{"type"=>"object", "properties"=>{"tag"=>{"$ref"=>"#/components/schemas/Tag"}}}}}, "description"=>"Post Response"}>  attributes :id, :create_time, :body, :picture_url, :audio_url, :audio_size, :audio_content_type, :person, :post_reaction_counts, :post_reaction, :global, :starts_at, :ends_at, :repost_interval, :status, :priority, :recommended, :notify_followers, :comment_count, :category, :tags

  def person
    PersonJsonSerializer.new(object.PersonJson)
  end

  def post_reaction
    PostReactionSerializer.new(object.PostReaction)
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  def create_time
    type_check(:create_time, [String])
    object.create_time
  end

  def body
    type_check(:body, [String])
    object.body
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def audio_url
    type_check(:audio_url, [String])
    object.audio_url
  end

  def audio_size
    type_check(:audio_size, [Integer])
    object.audio_size
  end

  def audio_content_type
    type_check(:audio_content_type, [String])
    object.audio_content_type
  end

  def post_reaction_counts
    type_check(:post_reaction_counts, [Integer])
    object.post_reaction_counts
  end

  def global
    type_check(:global, [TrueClass, FalseClass])
    object.global
  end

  def starts_at
    type_check(:starts_at, [String])
    object.starts_at
  end

  def ends_at
    type_check(:ends_at, [String])
    object.ends_at
  end

  def repost_interval
    type_check(:repost_interval, [Integer])
    object.repost_interval
  end

  def status
    type_check(:status, [String])
    object.status
  end

  def priority
    type_check(:priority, [Integer])
    object.priority
  end

  def recommended
    type_check(:recommended, [TrueClass, FalseClass])
    object.recommended
  end

  def notify_followers
    type_check(:notify_followers, [TrueClass, FalseClass])
    object.notify_followers
  end

  def comment_count
    type_check(:comment_count, [Integer])
    object.comment_count
  end

  def category
    type_check(:category, [Hash])
    object.category
  end

  def tags
    type_check(:tags, [Array])
    object.tags
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
