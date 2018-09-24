class AddFollowingJsonResponse < Apigen::Migration
  def up
    add_model :following_response do
      type :object do
        id :string?
        follower :person_response
        followed :person_response?
      end
    end

    add_model :followed_response do
      type :object do
        id :string?
        follower :person_response?
        followed :person_response
      end
    end
  end
end