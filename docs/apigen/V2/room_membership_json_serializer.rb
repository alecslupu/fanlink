class RoomMembershipJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2478ef8 @name="RoomMembershipJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}}, "description"=>"Room Membership Response"}>  attributes :id


  def id
    type_check(:id, [Integer])
    object.id
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
