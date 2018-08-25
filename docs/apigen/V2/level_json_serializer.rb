class LevelJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff24648e0 @name="LevelJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "internal_name"=>{"type"=>"string"}, "description"=>{"type"=>"string"}, "points"=>{"type"=>"integer"}, "picture_url"=>{"type"=>"string"}}, "description"=>"Level Response"}>  attributes :id, :name, :internal_name, :description, :points, :picture_url


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

  def points
    type_check(:points, [Integer])
    object.points
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
