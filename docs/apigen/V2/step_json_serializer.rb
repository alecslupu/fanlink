class StepJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2478868 @name="StepJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "quest_id"=>{"type"=>"integer"}, "unlocks"=>{"type"=>"array", "items"=>{"type"=>"integer"}}, "display"=>{"type"=>"string"}, "status"=>{"type"=>"string"}, "quest_activities"=>{"type"=>"array", "items"=>{"$ref"=>"#/components/schemas/QuestActivity"}}, "delay_unlock"=>{"type"=>"integer"}, "unlocks_at"=>{"type"=>"string", "format"=>"date-time"}}, "description"=>"Step Response"}>  attributes :id, :quest_id, :unlocks, :display, :status, :quest_activities, :delay_unlock, :unlocks_at

  def quest_activities
    ActiveModel::Serializer::CollectionSerializer.new(
      object.quest_activities,
      serializer: QuestActivitySerializer,
    )
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  def quest_id
    type_check(:quest_id, [Integer])
    object.quest_id
  end

  def unlocks
    type_check(:unlocks, [Array])
    object.unlocks
  end

  def display
    type_check(:display, [String])
    object.display
  end

  def status
    type_check(:status, [String])
    object.status
  end

  def delay_unlock
    type_check(:delay_unlock, [Integer])
    object.delay_unlock
  end

  def unlocks_at
    type_check(:unlocks_at, [String])
    object.unlocks_at
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
