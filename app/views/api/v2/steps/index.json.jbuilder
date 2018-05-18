json.steps do
    json.array!(@steps) do |step|
      json.partial! "step", locals: { step: step, lang: @lang }
    end
  end