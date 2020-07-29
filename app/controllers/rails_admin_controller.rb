# frozen_string_literal: true

class RailsAdminController < ApplicationController
  include Messaging
  include ::Pundit
  before_action :set_language
  set_current_tenant_through_filter
  before_action :require_login, :set_tenant, :set_api_version
  # before_action :reload_rails_admin

  def not_authenticated
    # Make sure that we reference the route from the main app.
    redirect_to(main_app.admin_login_screen_path(product_internal_name: 'admin')) && (return)
  end

  def require_login
    unless logged_in?
      session[:return_to_url] = '/admin_portal/'
      send(Config.not_authenticated_action)
      # else
      #   not_found unless current_user.product_id == Product.first.id && current_user.role == "super_admin"
    end
  end

  protected

  def set_language
    I18n.locale = :en
  end

  def set_api_version
    @api_version = 5
  end

  def set_tenant
    # we always start from current_user's product
    product = current_user.product
    # we override if a params is provided
    product = Product.find_by(internal_name: params[:product_internal_name]) if params[:product_internal_name].present?
    # we override it, if is super admin and has a cookie
    product = Product.find_by(id: cookies[:product_id].to_i) if current_user.super_admin? && (cookies[:product_id].to_i > 0)

    if product.present?
      set_current_tenant(product)
      cookies[:product_internal_name] = ((current_user.present?) ? current_user.product : product).internal_name
    else
      head :not_found
    end
  end


  def reload_rails_admin
    models = ApplicationRecord.descendants
    models.each do |m|
      RailsAdmin::Config.reset_model(m)
    end
    RailsAdmin::Config::Actions.reset

    load("#{Rails.root}/config/initializers/rails_admin.rb")
    Dir[Rails.root.join('config/initializers/rails_admin/**/*.rb')].each { |f| load(f) }
  end

  def rails_admin_path?
    controller_path =~ /app/ && Rails.env.development?
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
