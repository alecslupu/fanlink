module Admin
  class ProductsController < Admin::ApplicationController
    before_action :check_super
    before_action :set_paper_trail_whodunnit
    skip_before_action :set_tenant
    after_action :clear_cors_cache, only: %i[ create update destroy ]

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Product.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Product.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    def select
      product = nil
      product_id = params[:product_id].to_i
      if product_id > 0
        product = Product.find_by(id: product_id)
      end
      if product.present?
        cookies[:product_id] = product.id
        redirect_to admin_people_path
      else
        redirect_to select_form_admin_products_path
      end
    end

    def select_form
      @selected_id = session[:product_id]
      @products = Product.order(:name)
    end

  private

    def clear_cors_cache
      CorsGuard.invalidate
    end
  end
end
