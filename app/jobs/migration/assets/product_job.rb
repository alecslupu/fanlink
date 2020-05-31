module Migration
  module Assets
    class ProductJob < ::Migration::Assets::ApplicationJob

      def perform(product_id)
        require 'open-uri'
        product = ::Product.find(product_id)
        url = paperclip_asset_url(product, "logo", product)
        product.logo.attach(io: open(url), filename: product.logo_file_name, content_type: product.logo_content_type)
      end
    end

  end
end
