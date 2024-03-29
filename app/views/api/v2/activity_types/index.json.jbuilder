# frozen_string_literal: true

json.types do
  json.array!(@activity_types) do |atype|
    json.partial! 'type', locals: { atype: atype, lang: @lang }
  end
end
