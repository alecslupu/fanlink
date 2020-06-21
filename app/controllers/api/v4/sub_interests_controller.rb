# frozen_string_literal: true

module Api
  module V4
    class SubInterestsController < Api::V3::SubInterestsController
      def index
        @sub_interests = SubInterast.all
        return_the @sub_interests, handler: tpl_handler
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
