module Routing
  module Constraints
    class V3 < BaseApiVersion
      def self.matches?(request)
        super request, "v3"
      end
    end
  end
end
