# frozen_string_literal: true

module Api
  module V4
    module Courseware
      class WishlistsController < ApiController
        def index
          @wishlist = paginate(current_user.courseware_wishlists.includes(:certificate))
          render :index, handler: :jb
        end

        def create
          certificate = Certificate.find(params[:certificate_id])

          @wished_item = current_user.courseware_wishlists.create(certificate_id: certificate.id)
          if @wished_item.valid?
            head :ok
          else
            render_422 @wished_item.errors
          end
        end

        def destroy
          @wished_item = current_user.courseware_wishlists.where(certificate_id: params[:id]).first!
          if @wished_item.destroy
            head :ok
          else
            render_422 @wished_item.errors
          end
        end
      end
    end
  end
end
