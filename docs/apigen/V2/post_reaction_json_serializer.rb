class PostReactionJsonSerializer < ActiveModel::Serializer
nil#<Openapi2ruby::Openapi::Schema:0x00007ffff246c720 @name="PostReactionJson", @definition={"type"=>"object", "properties"=>{"id"=>{"type"=>"integer"}, "post_id"=>{"type"=>"integer"}, "person_id"=>{"type"=>"integer"}, "reaction"=>{"type"=>"string"}}, "description"=>"Post Reaction Response"}>  attributes :id, :post_id, :person_id, :reaction


  def id
    type_check(:id, [Integer])
    object.id
  end

  def post_id
    type_check(:post_id, [Integer])
    object.post_id
  end

  def person_id
    type_check(:person_id, [Integer])
    object.person_id
  end

  def reaction
    type_check(:reaction, [String])
    object.reaction
  end

  private

  def type_check(name, types)
    raise "Field type is invalid. #{name}" unless types.include?(object.send(name).class)
  end
end
