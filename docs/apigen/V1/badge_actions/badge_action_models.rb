FanlinkApi::API.model :pending_badge_json do
  type :object do
    pending_badge :object do
      badge_action_count :int32
      type :badge_json
    end
  end
end

FanlinkApi::API.model :badges_awarded_json do
  type :object do
    badges_awarded :object do
      type :badge_json
    end
  end
end
