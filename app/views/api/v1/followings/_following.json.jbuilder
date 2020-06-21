# frozen_string_literal: true

json.id following.id.to_s
json.follower following.follower, partial: 'api/v1/people/person', as: :person
json.followed following.followed, partial: 'api/v1/people/person', as: :person
