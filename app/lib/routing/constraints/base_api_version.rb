# frozen_string_literal: true

module Routing
  module Constraints
    class BaseApiVersion

      def self.matches?(request, version)
        request.headers['Accept'] && request.headers['Accept'] == api_version(version)
      end

      protected
      def self.api_version(version)
        "application/vnd.api."+version+"+json"
      end
    end
  end
end
