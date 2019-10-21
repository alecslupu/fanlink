RailsAdmin::Config::Fields::Types::Json.inspect # Load before override.
class RailsAdmin::Config::Fields::Types::Json
  def queryable?
    false
  end
end
