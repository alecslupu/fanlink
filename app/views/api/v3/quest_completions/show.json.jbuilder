# frozen_string_literal: true

json.completion do
  json.partial! 'completion', locals: { completion: @completion }
end
