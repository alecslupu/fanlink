class AddPostReactionJsonResponse < Apigen::Migration
  def up
    add_model :post_reaction_response do
      type :object do
        id :string?
        post_id :int32?
        person_id :int32?
        reaction :string?
      end
    end
  end
end
