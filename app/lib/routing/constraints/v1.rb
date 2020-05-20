# frozen_string_literal: true
module Routing
  module Constraints
    class V1 < BaseApiVersion
      def self.matches?(request)
        super request, "v1"
      end
    end
  end
end
