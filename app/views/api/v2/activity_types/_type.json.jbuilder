# frozen_string_literal: true
unless atype.deleted
  json.id atype.id
  json.activity_id atype.activity_id
  json.type atype.atype
  case atype.atype.to_sym
  when :beacon
    json.value do
      json.partial! "api/v2/product_beacons/beacon", locals: { beacon: ProductBeacon.find(atype.value["id"]) }
    end
  else
    json.value atype.value
  end

  json.orig_value atype.value
end
