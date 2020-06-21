# frozen_string_literal: true

module Routing
  module Constraints
    class V2 < BaseApiVersion
      def self.matches?(request)
        super request, "v2"
      end
    end
  end
end
