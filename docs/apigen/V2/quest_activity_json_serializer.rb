class QuestActivityJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff247a500 @name="QuestActivityJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "quest_id"=>{"type"=>"integer"}, "step_id"=>{"type"=>"integer"}, "description"=>{"type"=>"string"}, "hint"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "picture_width"=>{"type"=>"integer"}, "picture_height"=>{"type"=>"integer"}, "completed"=>{"type"=>"boolean"}, "requirements"=>{"type"=>"array", "items"=>{"$ref"=>"#/components/schemas/ActivityType"}}, "deleted"=>{"type"=>"boolean"}, "step"=>{"$ref"=>"#/components/schemas/Step"}, "created_at"=>{"type"=>"string", "format"=>"date-time"}}, "description"=>"Quest Activity Response"}>  attributes :id, :quest_id, :step_id, :description, :hint, :picture_url, :picture_width, :picture_height, :completed, :requirements, :deleted, :step, :created_at

  def requirements
    ActiveModel::Serializer::CollectionSerializer.new(
      object.requirements,
      serializer: ActivityTypeSerializer,
    )
  end

  def step
    StepSerializer.new(object.Step)
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  def quest_id
    type_check(:quest_id, [Integer])
    object.quest_id
  end

  def step_id
    type_check(:step_id, [Integer])
    object.step_id
  end

  def description
    type_check(:description, [String])
    object.description
  end

  def hint
    type_check(:hint, [String])
    object.hint
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

  def completed
    type_check(:completed, [TrueClass, FalseClass])
    object.completed
  end

  def deleted
    type_check(:deleted, [TrueClass, FalseClass])
    object.deleted
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
