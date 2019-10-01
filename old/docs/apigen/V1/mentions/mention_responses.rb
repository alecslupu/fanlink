class AddMentionJsonResponse < Apigen::Migration
  def up
    add_model :mention_response do
      type :object do
        id :string
        person_id :int32
        location :int32
        length :int32
      end
    end
  end
end
