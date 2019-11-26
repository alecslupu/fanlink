module Routing
  module Constraints
    class BaseApiVersion
      protected
      def api_version(version)
        "application/vnd.api."+version+"+json"
      end


      def self.matches?(request, version)
        request.headers['Accept'] && request.headers['Accept'] == api_version(version)
      end
    end
  end
end
