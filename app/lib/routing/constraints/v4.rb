# frozen_string_literal: true

module Routing
  module Constraints
    class V4 < BaseApiVersion
      def self.matches?(request)
        super request, 'v4'
      end
    end
  end
end
