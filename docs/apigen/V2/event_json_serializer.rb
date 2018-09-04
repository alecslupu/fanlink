class EventJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff2464f20 @name="EventJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "name"=>{"type"=>"string"}, "description"=>{"type"=>"string"}, "starts_at"=>{"type"=>"string", "format"=>"date-time"}, "ends_at"=>{"type"=>"string", "format"=>"date-time"}, "ticket_url"=>{"type"=>"string"}, "place_identifier"=>{"type"=>"string"}}, "description"=>"Event Response"}>  attributes :id, :name, :description, :starts_at, :ends_at, :ticket_url, :place_identifier


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

  def starts_at
    type_check(:starts_at, [String])
    object.starts_at
  end

  def ends_at
    type_check(:ends_at, [String])
    object.ends_at
  end

  def ticket_url
    type_check(:ticket_url, [String])
    object.ticket_url
  end

  def place_identifier
    type_check(:place_identifier, [String])
    object.place_identifier
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
