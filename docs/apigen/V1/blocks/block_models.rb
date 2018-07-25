FanlinkApi::API.model :block_app_json do
  type :object do
    block :object do
      id :int32
      blocker_id :int32
      blocked_id :int32
    end
  end
end
