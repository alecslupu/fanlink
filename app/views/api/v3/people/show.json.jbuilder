# frozen_string_literal: true

json.person do
  json.partial! 'person', locals: { person: @person }
end
