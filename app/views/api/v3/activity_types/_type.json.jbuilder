# frozen_string_literal: true

json.cache! ["v3", atype.updated_at, atype] do
  json.id atype.id
  json.activity_id atype.activity_id
  json.type atype.atype
  json.orig_value atype.value
  case atype.atype.to_sym
  when :beacon
    beacon = ProductBeacon.find(atype.value["id"])
    json.value do
      json.cache! ["v3", beacon], expires_in: 10.minutes do
        json.partial! "api/v3/product_beacons/beacon", locals: { beacon: beacon }
      end
    end
  else
    json.value atype.value
  end
end
