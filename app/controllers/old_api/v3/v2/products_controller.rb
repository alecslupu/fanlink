class Api::V2::ProductsController < ApiController
    include Rails::Pagination
    include Wisper::Publisher
    before_action :super_admin_only

    def select
        @products = Product.all
        return_the @products
    end

    def index
        @products = paginate(Product.all)
        return_the @products
    end

    def create
        @product = Product.create(product_params)
        if @product.valid?
            return_the @product
        else
            render json: { errors: @product.errors.messages }, status: :unprocessable_entity
        end
    end

    def show
        @product = Product.find(params[:id])
        if @product.valid?
            return_the @product
        else
            render json: { errors: @product.errors.messages }, status: :unprocessable_entity
        end
    end

    def update
        @product = Product.find(params[:id])
        if @product.update_attributes(product_params)
            return_the @product
        else
            render json: { errors: @product.errors.messages }, status: :unprocessable_entity
        end
    end

    def destroy
        
    end

private
    def product_params
        params.require(:product).permit(:name, :internal_name, :enabled)
    end
end