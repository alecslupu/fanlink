# frozen_string_literal: true

json.cache! ['v3', @assigned] do
  json.assigned @assigned, partial: 'assigned', as: :assigned
end
