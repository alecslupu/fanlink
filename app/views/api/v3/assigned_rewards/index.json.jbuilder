# frozen_string_literal: true

json.assignees do
  json.array!(@assignees) do |assigned|
    json.cache! ['v3', assigned] do
      json.partial! 'assigned', locals: { assigned: assigned }
    end
  end
end
