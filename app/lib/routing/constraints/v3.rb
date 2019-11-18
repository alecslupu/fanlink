module Routing
  module Constraints
    class V3
      def self.matches?(request)
        request.headers['Accept'] &&
        request.headers['Accept'].equal?("application/vnd.api.v3+json")
      end
    end
  end
end
