class NotificationDeviceIdJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246efe8 @name="NotificationDeviceIdJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}}, "description"=>"Notification Type ID Response"}>  attributes :id


  def id
    type_check(:id, [Integer])
    object.id
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
