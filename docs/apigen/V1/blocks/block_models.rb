FanlinkApi::API.model :block_json do
  type :object do
    block :object do
      id :int32
      blocker_id :int32
      blocked_id :int32
      created_at :string
    end
  end
end
