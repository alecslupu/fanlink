class AddLevelJsonResponse < Apigen::Migration
  def up
    add_model :level_response do
      type :object do
        id :string?
        internal_name :string?
        points :int32?
        picture_url :string?
        description :string?
        name :string?
      end
    end
  end
end