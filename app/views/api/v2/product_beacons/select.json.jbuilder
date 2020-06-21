# frozen_string_literal: true

json.beacons @product_beacons do |beacon|
  json.id beacon.id.to_s
  json.product_id beacon.product_id.to_s
  json.beacon_pid beacon.beacon_pid
end
