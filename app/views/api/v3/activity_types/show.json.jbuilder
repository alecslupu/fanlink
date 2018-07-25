json.type do
    json.cache! ['v3', @activity_type], expires_in: 10.minutes do
        json.partial! "type", locals: { atype: @activity_type, lang: nil }
    end
    case @activity_type.atype.to_sym
    when :beacon
        beacon = ProductBeacon.find(atype.value['id'])
        json.value do
            json.cache! ['v3', beacon], expires_in: 10.minutes do
                json.partial! "api/v3/product_beacons/beacon", locals: { beacon: beacon }
            end
        end
    else
        json.value @activity_type.value
    end
end
