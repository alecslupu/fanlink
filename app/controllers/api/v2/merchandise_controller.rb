# frozen_string_literal: true

module Api
  module V2
    class MerchandiseController < Api::V1::MerchandiseController
      load_up_the Merchandise, only: %i[update show delete]

      def create
        @merchandise = Merchandise.create(merchandise_params)
        if @merchandise.valid?
          broadcast(:merchandise_created, current_user, @merchandise)
          return_the @merchandise
        else
          render json: { errors: @merchandise.errors.messages.flatten }, status: :unprocessable_entity
        end
      end

      def update
        if @merchandise.update(merchandise_params)
          broadcast(:merchandise_updated, current_user, @merchandise)
          return_the @merchandise
        else
          render json: { errors: @merchandise.errors.messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if some_admin?
          @merchandise.deleted = true
          @merchandise.save
          head :ok
        else
          render_not_found
        end
      end

      private

      def merchandise_params
        params.require(:merchandise).permit(:price, :picture, :available, :priority, :name, :description, :purchase_url)
      end
    end
  end
end
