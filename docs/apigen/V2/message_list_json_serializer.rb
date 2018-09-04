class MessageListJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246f470 @name="MessageListJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "person_id"=>{"type"=>"integer"}, "room_id"=>{"type"=>"integer"}, "body"=>{"type"=>"string"}, "hidden"=>{"type"=>"boolean"}, "picture_url"=>{"type"=>"string"}, "created_at"=>{"type"=>"string", "format"=>"date-time"}, "updated_at"=>{"type"=>"string", "format"=>"date-time"}}, "description"=>"Message Response"}>  attributes :id, :person_id, :room_id, :body, :hidden, :picture_url, :created_at, :updated_at


  def id
    type_check(:id, [Integer])
    object.id
  end

  def person_id
    type_check(:person_id, [Integer])
    object.person_id
  end

  def room_id
    type_check(:room_id, [Integer])
    object.room_id
  end

  def body
    type_check(:body, [String])
    object.body
  end

  def hidden
    type_check(:hidden, [TrueClass, FalseClass])
    object.hidden
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def created_at
    type_check(:created_at, [String])
    object.created_at
  end

  def updated_at
    type_check(:updated_at, [String])
    object.updated_at
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
