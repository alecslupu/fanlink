class TagJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff24783e0 @name="TagJson", @definition={"type"=>"object", "properties"=>{"name"=>{"type"=>"string"}}, "description"=>"Tag Response"}>  attributes :name


  def name
    type_check(:name, [String])
    object.name
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
