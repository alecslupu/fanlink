class MessageReportJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff24640c0 @name="MessageReportJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "created_at"=>{"type"=>"string", "format"=>"date-time"}, "updated_at"=>{"type"=>"string", "format"=>"date-time"}, "message_id"=>{"type"=>"integer"}, "poster"=>{"type"=>"string"}, "reporter"=>{"type"=>"string"}, "reason"=>{"type"=>"string"}, "status"=>{"type"=>"string"}}, "description"=>"Message Report Response"}>  attributes :id, :created_at, :updated_at, :message_id, :poster, :reporter, :reason, :status


  def id
    type_check(:id, [Integer])
    object.id
  end

  def created_at
    type_check(:created_at, [String])
    object.created_at
  end

  def updated_at
    type_check(:updated_at, [String])
    object.updated_at
  end

  def message_id
    type_check(:message_id, [Integer])
    object.message_id
  end

  def poster
    type_check(:poster, [String])
    object.poster
  end

  def reporter
    type_check(:reporter, [String])
    object.reporter
  end

  def reason
    type_check(:reason, [String])
    object.reason
  end

  def status
    type_check(:status, [String])
    object.status
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
