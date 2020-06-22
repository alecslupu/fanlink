# frozen_string_literal: true

json.people do
  json.array! @people do |person|
    next if current_user.blocks_by.where(blocked_id: person.id).exists?
    json.partial! 'person_private', locals: { person: person }
  end
end
