# frozen_string_literal: true

RailsAdmin::Config::Fields::Types::Json.inspect # Load before override.
class RailsAdmin::Config::Fields::Types::Json
  def queryable?
    false
  end

  register_instance_option :export_value do
    formatted_value.html_safe
  end

end
