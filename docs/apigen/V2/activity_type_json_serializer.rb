class ActivityTypeJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2465ba0 @name="ActivityTypeJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "atype"=>{"type"=>"string"}, "activity_id"=>{"type"=>"integer"}, "value"=>{"type"=>"object", "properties"=>{"id"=>{"type"=>"string"}, "description"=>{"type"=>"string"}}}}, "description"=>"Activity Type Object"}>  attributes :id, :atype, :activity_id, :value


  def id
    type_check(:id, [Integer])
    object.id
  end

  def atype
    type_check(:atype, [String])
    object.atype
  end

  def activity_id
    type_check(:activity_id, [Integer])
    object.activity_id
  end

  def value
    type_check(:value, [Hash])
    object.value
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
