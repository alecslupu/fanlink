class MentionJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246fc18 @name="MentionJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "person_id"=>{"type"=>"integer"}, "location"=>{"type"=>"integer"}, "length"=>{"type"=>"integer"}}, "description"=>"Notification Type ID Response"}>  attributes :id, :person_id, :location, :length


  def id
    type_check(:id, [Integer])
    object.id
  end

  def person_id
    type_check(:person_id, [Integer])
    object.person_id
  end

  def location
    type_check(:location, [Integer])
    object.location
  end

  def length
    type_check(:length, [Integer])
    object.length
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
