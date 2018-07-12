if current_user.role == 'super_admin'
    json.merchandise @merchandise, partial: "merchandise", as: :merchandise
else
    json.merchandise do
        json.array!(@merchandise) do |merch|
          next if merch.deleted
          json.partial! "merchandise", locals: { merchandise: merch, lang: @lang }
        end
    end
end
