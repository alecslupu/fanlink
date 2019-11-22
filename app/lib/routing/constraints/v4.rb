module Routing
  module Constraints
    class V4
      def self.matches?(request)
        request.headers['Accept'] &&
        request.headers['Accept'].equal?("application/vnd.api.v4+json")
      end
    end
  end
end
