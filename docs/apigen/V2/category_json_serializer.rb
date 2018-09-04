class CategoryJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff24652b8 @name="CategoryJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "product_id"=>{"type"=>"integer"}, "color"=>{"type"=>"string"}, "role"=>{"type"=>"string"}, "posts"=>{"type"=>"array", "items"=>{"type"=>"object", "properties"=>{"post"=>{"$ref"=>"#/components/schemas/Post"}}}}}}>  attributes :id, :name, :product_id, :color, :role, :posts


  def id
    type_check(:id, [Integer])
    object.id
  end

  def name
    type_check(:name, [String])
    object.name
  end

  def product_id
    type_check(:product_id, [Integer])
    object.product_id
  end

  def color
    type_check(:color, [String])
    object.color
  end

  def role
    type_check(:role, [String])
    object.role
  end

  def posts
    type_check(:posts, [Array])
    object.posts
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
