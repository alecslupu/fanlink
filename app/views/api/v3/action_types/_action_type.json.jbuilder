# frozen_string_literal: true

json.(action, :id, :name, :internal_name, :seconds_lag)
json.created_at action.created_at.to_s
json.updated_at action.updated_at.to_s
