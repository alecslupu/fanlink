class MessageJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246f970 @name="MessageJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "create_time"=>{"type"=>"string", "format"=>"date-time"}, "body"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "audio_url"=>{"type"=>"string"}, "audio_size"=>{"type"=>"string"}, "audio_content_type"=>{"type"=>"string"}, "person"=>{"$ref"=>"#/components/schemas/PersonJson"}, "mentions"=>{"$ref"=>"#/components/schemas/Mention"}}, "description"=>"Message Response"}>  attributes :id, :create_time, :body, :picture_url, :audio_url, :audio_size, :audio_content_type, :person, :mentions

  def person
    PersonJsonSerializer.new(object.PersonJson)
  end

  def mentions
    MentionSerializer.new(object.Mention)
  end


  def id
    type_check(:id, [Integer])
    object.id
  end

  def create_time
    type_check(:create_time, [String])
    object.create_time
  end

  def body
    type_check(:body, [String])
    object.body
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def audio_url
    type_check(:audio_url, [String])
    object.audio_url
  end

  def audio_size
    type_check(:audio_size, [String])
    object.audio_size
  end

  def audio_content_type
    type_check(:audio_content_type, [String])
    object.audio_content_type
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
