json.types do
    json.array!(@activity_types) do |atype|
        next if atype.deleted
        json.cache! ['v3', atype], expires_in: 10.minutes do
            json.partial! "type", locals: { atype: atype, lang: @lang }
        end
        case atype.atype.to_sym
        when :beacon
            beacon = ProductBeacon.find(atype.value['id'])
            json.value do
                json.cache! ['v3', beacon], expires_in: 10.minutes do
                    json.partial! "api/v3/product_beacons/beacon", locals: { beacon: beacon }
                end
            end
        else
            json.value atype.value
        end
    end
  end
