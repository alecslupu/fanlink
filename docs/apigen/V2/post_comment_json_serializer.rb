class PostCommentJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246cec8 @name="PostCommentJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "create_time"=>{"type"=>"string", "format"=>"date-time"}, "body"=>{"type"=>"string"}, "mentions"=>{"type"=>"array", "items"=>{"type"=>"object", "properties"=>{"mention"=>{"$ref"=>"#/components/schemas/Mention"}}}}, "person"=>{"$ref"=>"#/components/schemas/PersonJson"}}, "description"=>"Post Comment Response"}>  attributes :id, :create_time, :body, :mentions, :person

  def person
    PersonJsonSerializer.new(object.PersonJson)
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

  def mentions
    type_check(:mentions, [Array])
    object.mentions
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
