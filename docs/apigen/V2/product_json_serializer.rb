class ProductJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff247a7a8 @name="ProductJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "internal_name"=>{"type"=>"string"}, "enabled"=>{"type"=>"boolean"}}, "description"=>"Product Response"}>  attributes :id, :name, :internal_name, :enabled


  def id
    type_check(:id, [Integer])
    object.id
  end

  def name
    type_check(:name, [String])
    object.name
  end

  def internal_name
    type_check(:internal_name, [String])
    object.internal_name
  end

  def enabled
    type_check(:enabled, [TrueClass, FalseClass])
    object.enabled
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
