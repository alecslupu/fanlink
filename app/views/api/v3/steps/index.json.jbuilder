# frozen_string_literal: true

json.steps do
  json.array!(@steps) do |step|
    next if step.deleted && current_user.role != 'super_admin'

    json.partial! 'step', locals: { step: step, lang: @lang }
  end
end
