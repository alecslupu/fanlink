if Rails.env.development?
  require 'open_api/dsl'
  class ApiDoc < Object
    include OpenApi::DSL
    include AutoGenDoc
    Object.const_set('Boolean', 'boolean')
    class << self
    end
  end
end
