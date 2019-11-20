class AddBadgeJsonResponse < Apigen::Migration
  def up
    add_model :badge_response do
      type :object do
        id :string?
        name :string?
        internal_name :string?
        description :string?
        picture_url :string?
        action_requirement :int32?
        point_value :int32?
      end
    end
  end
end