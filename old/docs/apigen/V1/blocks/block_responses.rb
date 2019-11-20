class AddBlockJsonResponse < Apigen::Migration
  def up
    add_model :block_response do
      type :object do
        id :string?
        blocker_id :int32?
        blocked_id :int32?
      end
    end
  end
end