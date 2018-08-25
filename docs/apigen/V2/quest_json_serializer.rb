class QuestJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2479a88 @name="QuestJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "product_id"=>{"type"=>"integer"}, "event_id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "internal_name"=>{"type"=>"string"}, "description"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "picture_width"=>{"type"=>"integer"}, "picture_height"=>{"type"=>"integer"}, "status"=>{"type"=>"string"}, "starts_at"=>{"type"=>"string", "format"=>"date-time"}, "ends_at"=>{"type"=>"string", "format"=>"date-time"}, "create_time"=>{"type"=>"string", "format"=>"date-time"}, "steps"=>{"type"=>"array", "items"=>{"$ref"=>"#/components/schemas/Step"}}}, "description"=>"Step Response"}>  attributes :id, :product_id, :event_id, :name, :internal_name, :description, :picture_url, :picture_width, :picture_height, :status, :starts_at, :ends_at, :create_time, :steps

  def steps
    ActiveModel::Serializer::CollectionSerializer.new(
      object.steps,
      serializer: StepSerializer,
    )
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  def product_id
    type_check(:product_id, [Integer])
    object.product_id
  end

  def event_id
    type_check(:event_id, [Integer])
    object.event_id
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

  def picture_width
    type_check(:picture_width, [Integer])
    object.picture_width
  end

  def picture_height
    type_check(:picture_height, [Integer])
    object.picture_height
  end

  def status
    type_check(:status, [String])
    object.status
  end

  def starts_at
    type_check(:starts_at, [String])
    object.starts_at
  end

  def ends_at
    type_check(:ends_at, [String])
    object.ends_at
  end

  def create_time
    type_check(:create_time, [String])
    object.create_time
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
