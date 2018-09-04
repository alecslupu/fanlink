class QuestCompletionJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2479e20 @name="QuestCompletionJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "person_id"=>{"type"=>"integer"}, "step_id"=>{"type"=>"integer"}, "activity_id"=>{"type"=>"integer"}, "status"=>{"type"=>"string"}, "create_time"=>{"type"=>"string", "format"=>"date-time"}}}>  attributes :id, :person_id, :step_id, :activity_id, :status, :create_time


  def id
    type_check(:id, [Integer])
    object.id
  end

  def person_id
    type_check(:person_id, [Integer])
    object.person_id
  end

  def step_id
    type_check(:step_id, [Integer])
    object.step_id
  end

  def activity_id
    type_check(:activity_id, [Integer])
    object.activity_id
  end

  def status
    type_check(:status, [String])
    object.status
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
