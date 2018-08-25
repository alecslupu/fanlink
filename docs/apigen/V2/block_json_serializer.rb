class BlockJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff24654e8 @name="BlockJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "blocker_id"=>{"type"=>"integer"}, "blocked_id"=>{"type"=>"integer"}}, "description"=>"Block object"}>  attributes :id, :blocker_id, :blocked_id


  def id
    type_check(:id, [Integer])
    object.id
  end

  def blocker_id
    type_check(:blocker_id, [Integer])
    object.blocker_id
  end

  def blocked_id
    type_check(:blocked_id, [Integer])
    object.blocked_id
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
