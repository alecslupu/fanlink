module Routing
  module Constraints
    class V1
      def self.matches?(request)
        request.headers['Accept'] &&
        request.headers['Accept'].equal?("application/vnd.api.v1+json")
      end
    end
  end
end
