json.types do
    json.array!(@activity_types) do |atype|
      next if atype.deleted
      json.cache! ["v3", atype, @lang], expires_in: 10.minutes do
        json.partial! "type", locals: { atype: atype, lang: @lang }
      end
    end
  end
