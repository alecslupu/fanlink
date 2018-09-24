class AddBadgeActionJsonResponse < Apigen::Migration
  def up
    add_model :pending_badge_response do
      type :object do
        badge_action_count :int32
        badge :badge_response
      end
    end

    add_model :badges_awarded_response do
      type :object do
        badges_awarded :array do
          type :badge_response
        end
      end
    end
  end
end
