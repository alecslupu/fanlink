class RelationshipJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2479290 @name="RelationshipJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "status"=>{"type"=>"string"}, "create_time"=>{"type"=>"string", "format"=>"date-time"}, "update_time"=>{"type"=>"string", "format"=>"date-time"}, "requested_by"=>{"$ref"=>"#/components/schemas/PersonJson"}, "requested_to"=>{"$ref"=>"#/components/schemas/PersonJson"}}, "description"=>"Relationship Response"}>  attributes :id, :status, :create_time, :update_time, :requested_by, :requested_to

  def requested_by
    PersonJsonSerializer.new(object.PersonJson)
  end

  def requested_to
    PersonJsonSerializer.new(object.PersonJson)
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  def status
    type_check(:status, [String])
    object.status
  end

  def create_time
    type_check(:create_time, [String])
    object.create_time
  end

  def update_time
    type_check(:update_time, [String])
    object.update_time
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
