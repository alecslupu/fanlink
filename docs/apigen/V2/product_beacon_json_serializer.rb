class ProductBeaconJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff247abb8 @name="ProductBeaconJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "product_id"=>{"type"=>"integer"}, "beacon_pid"=>{"type"=>"string"}, "uuid"=>{"type"=>"string"}, "lower"=>{"type"=>"integer"}, "upper"=>{"type"=>"integer"}, "created_at"=>{"type"=>"string", "format"=>"date-time"}}, "description"=>"Product Beacon Response"}>  attributes :id, :product_id, :beacon_pid, :uuid, :lower, :upper, :created_at


  def id
    type_check(:id, [Integer])
    object.id
  end

  def product_id
    type_check(:product_id, [Integer])
    object.product_id
  end

  def beacon_pid
    type_check(:beacon_pid, [String])
    object.beacon_pid
  end

  def uuid
    type_check(:uuid, [String])
    object.uuid
  end

  def lower
    type_check(:lower, [Integer])
    object.lower
  end

  def upper
    type_check(:upper, [Integer])
    object.upper
  end

  def created_at
    type_check(:created_at, [String])
    object.created_at
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
