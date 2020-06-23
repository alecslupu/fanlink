# frozen_string_literal: true

require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
module RailsAdmin
  module Config
    module Actions
      class SelectProductDashboard < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :authorized? do
          enabled? && (
            bindings[:controller].try(:authorization_adapter).nil? || bindings[:controller].authorization_adapter.authorized?(authorization_key)
          )
        end

        register_instance_option :authorization_key do
          :select_product
        end

        register_instance_option :visible? do
          authorized?
        end

        register_instance_option :custom_key do
          :select_product_dashboard
        end

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
          '/select-product/'
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
            @products = Product.order(:name)
            render @action.template_name, status: @status_code || :ok
          end
        end

      end
    end
  end
end
