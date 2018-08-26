class PostListJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff247b388 @name="PostListJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "person"=>{"$ref"=>"#/components/schemas/PersonJson"}, "body"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "global"=>{"type"=>"boolean"}, "starts_at"=>{"type"=>"string", "format"=>"date-time"}, "ends_at"=>{"type"=>"string", "format"=>"date-time"}, "repost_interval"=>{"type"=>"integer"}, "status"=>{"type"=>"string"}, "priority"=>{"type"=>"integer"}, "recommended"=>{"type"=>"boolean"}, "notify_followers"=>{"type"=>"boolean"}, "comment_count"=>{"type"=>"integer"}, "category"=>{"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "color"=>{"type"=>"string"}, "role"=>{"type"=>"string"}}}, "tags"=>{"type"=>"array", "items"=>{"type"=>"object", "properties"=>{"tag"=>{"$ref"=>"#/components/schemas/Tag"}}}}}, "description"=>"List Post Response"}>  attributes :id, :person, :body, :picture_url, :global, :starts_at, :ends_at, :repost_interval, :status, :priority, :recommended, :notify_followers, :comment_count, :category, :tags

  def person
    PersonJsonSerializer.new(object.PersonJson)
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  def body
    type_check(:body, [String])
    object.body
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
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
