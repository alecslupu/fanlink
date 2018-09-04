class PostShareJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff247b5b8 @name="PostShareJson", @definition={"type"=>"object", "properties"=>{"body"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}, "person"=>{"type"=>"object", "properties"=>{"username"=>{"type"=>"string"}, "picture_url"=>{"type"=>"string"}}}}, "description"=>"Shared Post Response"}>  attributes :body, :picture_url, :person


  def body
    type_check(:body, [String])
    object.body
  end

  def picture_url
    type_check(:picture_url, [String])
    object.picture_url
  end

  def person
    type_check(:person, [Hash])
    object.person
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
