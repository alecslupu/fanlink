class SessionJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff24789a8 @name="SessionJson", @definition={"type"=>"object", "properties"=>{"person"=>{"$ref"=>"#/components/schemas/PersonPrivateJson"}}, "description"=>"Session Response"}>  attributes :person

  def person
    PersonPrivateJsonSerializer.new(object.PersonPrivateJson)
  end


  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
