# frozen_string_literal: true

if current_user.role == 'super_admin'
  json.merchandise do
    json.array(@merchandise) do |merch|
      json.cache! ['v3', merch, @lang] do
        json.partial! 'merchandise', locals: { merchandise: merch, lang: @lang }
      end
    end
  end
else
  json.merchandise do
    json.array!(@merchandise) do |merch|
      next if merch.deleted

      json.cache! ['v3', merch, @lang] do
        json.partial! 'merchandise', locals: { merchandise: merch, lang: @lang }
      end
    end
  end
end
