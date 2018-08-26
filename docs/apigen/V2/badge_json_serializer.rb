class BadgeJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff24658f8 @name="BadgeJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "internal_name"=>{"type"=>"string"}, "description"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "action_requirement"=>{"type"=>"integer"}, "point_value"=>{"type"=>"integer"}}, "description"=>"Badge Response"}>  attributes :id, :name, :internal_name, :description, :picture_url, :action_requirement, :point_value


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

  def description
    type_check(:description, [String])
    object.description
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def action_requirement
    type_check(:action_requirement, [Integer])
    object.action_requirement
  end

  def point_value
    type_check(:point_value, [Integer])
    object.point_value
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
