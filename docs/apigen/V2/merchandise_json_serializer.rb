class MerchandiseJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2464548 @name="MerchandiseJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "description"=>{"type"=>"string"}, "price"=>{"type"=>"integer"}, "purchase_url"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "available"=>{"type"=>"boolean"}, "priority"=>{"type"=>"integer"}}, "description"=>"Merchandise Response"}>  attributes :id, :name, :description, :price, :purchase_url, :picture_url, :available, :priority


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

  def price
    type_check(:price, [Integer])
    object.price
  end

  def purchase_url
    type_check(:purchase_url, [String])
    object.purchase_url
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def available
    type_check(:available, [TrueClass, FalseClass])
    object.available
  end

  def priority
    type_check(:priority, [Integer])
    object.priority
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
