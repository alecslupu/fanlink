module Routing
  module Constraints
    class V2
      def self.matches?(request)
        request.headers['Accept'] &&
        request.headers['Accept'].equal?("application/vnd.api.v2+json")
      end
    end
  end
end
