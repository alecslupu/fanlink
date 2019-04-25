module Fanlink

  module RailsAdmin
    module Config
      module Actions
        class SelectProductAction < ::RailsAdmin::Config::Actions::Base

          register_instance_option :authorized? do
            enabled? && (
            bindings[:controller].try(:authorization_adapter).nil? || bindings[:controller].authorization_adapter.authorized?(authorization_key)
            )
          end

          register_instance_option :authorization_key do
            :select_product
          end

          register_instance_option :visible? do
            false
          end

          register_instance_option :custom_key do
            :select_product_action
          end

          # Is the action on an object scope (Example: /admin/team/1/edit)
          register_instance_option :root? do
            true
          end

          register_instance_option :breadcrumb_parent do
            nil
          end

          register_instance_option :auditing_versions_limit do
            100
          end

          register_instance_option :route_fragment do
            '/select-product-id/'
          end

          register_instance_option :link_icon do
            'icon-home'
          end
          #
          # register_instance_option :statistics? do
          #   true
          # end

          register_instance_option :controller do
            proc do
              product = nil
              product_id = params[:product_id].to_i
              if product_id > 0
                product = Product.find_by(id: product_id)
              end
              if product.present?
                cookies[:product_id] = product.id
              end
              redirect_to dashboard_url
            end
          end

        end
      end
    end
  end
end
