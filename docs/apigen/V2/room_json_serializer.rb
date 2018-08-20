class RoomJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2478db8 @name="RoomJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "description"=>{"type"=>"string"}, "owned"=>{"type"=>"boolean"}, "picture_url"=>{"type"=>"string"}, "public"=>{"type"=>"boolean"}, "members"=>{"type"=>"array", "items"=>{"type"=>"object", "properties"=>{"member"=>{"$ref"=>"#/components/schemas/PersonJson"}}}}}, "description"=>"Room Response"}>  attributes :id, :name, :description, :owned, :picture_url, :public, :members


  def id
    type_check(:id, [Integer])
    object.id
  end

  def name
    type_check(:name, [String])
    object.name
  end

  def description
    type_check(:description, [String])
    object.description
  end

  def owned
    type_check(:owned, [TrueClass, FalseClass])
    object.owned
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def public
    type_check(:public, [TrueClass, FalseClass])
    object.public
  end

  def members
    type_check(:members, [Array])
    object.members
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
