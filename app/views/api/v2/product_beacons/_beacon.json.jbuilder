# frozen_string_literal: true
if !beacon.deleted
  json.id beacon.id.to_s
  json.product_id beacon.product_id.to_s
  json.beacon_pid beacon.beacon_pid
  json.uuid beacon.uuid
  json.lower beacon.lower.to_s
  json.upper beacon.upper.to_s
  # json.attached_to beacon.attached_to.to_s
  json.created_at beacon.created_at
end
