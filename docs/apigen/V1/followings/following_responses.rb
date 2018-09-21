class AddFollowingJsonResponse < Apigen::Migration
  def up
    add_model :following_response do
      type :object do
        id :string?
        follower :person_response
        following :person_response
      end
    end
  end
end