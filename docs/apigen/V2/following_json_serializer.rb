class FollowingJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2464b10 @name="FollowingJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "follower"=>{"$ref"=>"#/components/schemas/PersonJson"}, "followed"=>{"$ref"=>"#/components/schemas/PersonJson"}}, "description"=>"Following Response"}>  attributes :id, :follower, :followed

  def follower
    PersonJsonSerializer.new(object.PersonJson)
  end

  def followed
    PersonJsonSerializer.new(object.PersonJson)
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
