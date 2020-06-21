# frozen_string_literal: true

json.interests @person.interests.order(order: :desc), partial: 'api/v3/interests/flat_interest', as: :interest
