# frozen_string_literal: true

json.id relationship.id.to_s
json.status relationship.status
json.create_time relationship.created_at.to_s
json.update_time relationship.updated_at.to_s
json.requested_by relationship.requested_by, partial: 'api/v1/people/person', as: :person
json.requested_to relationship.requested_to, partial: 'api/v1/people/person', as: :person
