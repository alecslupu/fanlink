class PostCommentListJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246cba8 @name="PostCommentListJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "person_id"=>{"type"=>"integer"}, "post_id"=>{"type"=>"integer"}, "body"=>{"type"=>"string"}, "hidden"=>{"type"=>"boolean"}, "created_at"=>{"type"=>"string", "format"=>"date-time"}, "updated_at"=>{"type"=>"string", "format"=>"date-time"}, "mentions"=>{"type"=>"array", "items"=>{"type"=>"object", "properties"=>{"mention"=>{"$ref"=>"#/components/schemas/Mention"}}}}}, "description"=>"Post Comment Response"}>  attributes :id, :person_id, :post_id, :body, :hidden, :created_at, :updated_at, :mentions


  def id
    type_check(:id, [Integer])
    object.id
  end

  def person_id
    type_check(:person_id, [Integer])
    object.person_id
  end

  def post_id
    type_check(:post_id, [Integer])
    object.post_id
  end

  def body
    type_check(:body, [String])
    object.body
  end

  def hidden
    type_check(:hidden, [TrueClass, FalseClass])
    object.hidden
  end

  def created_at
    type_check(:created_at, [String])
    object.created_at
  end

  def updated_at
    type_check(:updated_at, [String])
    object.updated_at
  end

  def mentions
    type_check(:mentions, [Array])
    object.mentions
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
