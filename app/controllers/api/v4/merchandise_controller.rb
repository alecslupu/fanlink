# frozen_string_literal: true

module Api
  module V4
    class MerchandiseController < Api::V3::MerchandiseController
      def index
        @merchandise = paginate(Merchandise.listable.order(:priority))
        return_the @merchandise, handler: tpl_handler
      end

      def show
        @merchandise = Merchandise.listable.find(params[:id])
        return_the @merchandise, handler: tpl_handler
      end

      def create
        @merchandise = Merchandise.create(merchandise_params)
        if @merchandise.valid?
          broadcast(:merchandise_created, current_user, @merchandise)
          return_the @merchandise, handler: tpl_handler, using: :show
        else
          render_422 @merchandise.errors
        end
      end

      def update
        if params.has_key?(:merchandise)
          if @merchandise.update(merchandise_params)
            broadcast(:merchandise_updated, current_user, @merchandise)
            return_the @merchandise, handler: tpl_handler, using: :show
          else
            render_422 @merchandise.errors
          end
        else
          return_the @merchandise, handler: tpl_handler, using: :show
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
