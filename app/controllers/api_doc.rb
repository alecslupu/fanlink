require 'open_api/dsl'
class ApiDoc < Object
  include OpenApi::DSL
  include AutoGenDoc

  class << self
    def undo_dry
      @zro_dry_blocks = nil
    end

    def id
      [ :id ]
    end

    def none
      [ :none ]
    end
  end
end
