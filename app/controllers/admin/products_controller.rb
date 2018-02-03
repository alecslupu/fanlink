module Admin
  class ProductsController < Admin::ApplicationController

    before_action :check_super

    skip_before_action :set_tenant

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
      product_id = params[:product_id].to_i
      if product_id > 0
        product = Product.find_by(id: product_id)
        if product.present?
          cookies[:product_id] = product_id
          redirect_to admin_people_path and return
        end
      end
      redirect_to select_form_admin_products_path
    end

    def select_form
      @selected_id = session[:product_id]
      @products = Product.order(:name)
    end
  end
end
