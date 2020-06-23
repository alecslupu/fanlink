# frozen_string_literal: true

module Api
  module V1
    class MerchandiseController < ApiController
      def index
        @merchandise = Merchandise.listable.order(:priority)
      end

      def show
        @merchandise = Merchandise.listable.find(params[:id])
        return_the @merchandise
      end
    end
  end
end
