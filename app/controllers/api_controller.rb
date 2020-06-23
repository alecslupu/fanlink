# frozen_string_literal: true

class ApiController < ApplicationController
  include FloadUp
  include Rails::Pagination
  include Wisper::Publisher
  include JSONErrors
  include Orderable
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  set_current_tenant_through_filter

  before_action :set_language, :set_product, :set_api_version, :set_paper_trail_whodunnit, :set_person, :set_app, :check_banned, :set_default_format
  after_action :unset_person, :unset_app

  protected
  def set_default_format
    request.format = :json
  end

  def some_admin?
    !%w[normal client client_portal].include?(current_user.assigned_role.internal_name)
  end

  def web_request?
    @req_source == :web
  end

  def admin_only
    head :unauthorized unless some_admin?
  end

  def super_admin_only
    head :unauthorized unless current_user.role == 'super_admin'
  end

  def api_template(controller = nil, version = :v2, using)
    if controller.nil?
      render_404(_('Not found.'))
    else
      Rails.logger.debug("#{controller.to_s.downcase.singularize}_#{version}_#{using}")
      "#{controller.to_s.downcase.singularize}_#{version}_#{using}".to_sym
    end
  end

  def set_api_version
    # /api\/(?<version>v[0-9]+)\/(?<template>\w+)/ =~ params[:controller]
    # /\Aapplication\/vnd\.api\.v(?<version>[0-9]+)\+json\z/ =~ request.headers['Accept']a
    @api_version = 4
  end

  def check_banned
    if current_user&.terminated
      logout
      cookies.delete :_fanlink_session
      head :unauthorized if current_user.terminated
    end
  end

  def check_dates(required = false)
    if params[:from_date].present?
      return false unless DateUtil.valid_date_string?(params[:from_date])
    else
      return false if required
    end
    if params[:to_date].present?
      return false unless DateUtil.valid_date_string?(params[:to_date])
    else
      return false if required
    end
    true
  end

  def find_device_type
    case request.user_agent
    when /iOS|CFNetwork/i
      :ios
    when /android|okhttp/i
      :android
    when /Mozilla|Chrome|Safari/i
      :web
    else
      :unknown
    end
  end

  def render_error(error)
    render_422(error)
  end

  def render_not_found
    render_404('Not found.')
  end

  def set_language
    @lang = nil
    lang_header = request.headers['Accept-Language']
    if lang_header.present?
      if lang_header.length > 2
        lang_header = lang_header[0..1]
      end
      @lang = lang_header if TranslationThings::LANGS[lang_header].present?
    end
    @lang = TranslationThings::DEFAULT_READ_LANG if @lang.nil?
    I18n.locale = @lang
  end

  def set_product
    product = nil
    if current_user.present?
      if current_user.super_admin?
        if request.headers['X-Current-Product'].present?
          product = Product.find_by(internal_name: request.headers['X-Current-Product'])
        else
          product = Product.find_by(internal_name: params[:product]) if params[:product]
          product = current_user.try(:product) if product.nil?
        end
      end
    end
    product = (current_user.present? && current_user.try(:product)) || Product.find_by(internal_name: params[:product]) if product.nil?
    if product.nil?
      render json: { errors: 'You must supply a valid product' }, status: :unprocessable_entity
    else
      set_current_tenant(product)
      cookies[:product_internal_name] = ((current_user.present?) ? current_user.product.internal_name : product.internal_name)
    end
  end

  def not_authenticated
    head :unauthorized
  end

  def set_person
    if current_user.present?
      Person.current_user = current_user
    end
  end

  def unset_person
    Person.current_user = nil
  end

  def set_app
    @device = find_device_type
    @req_source = 'app'
    @req_source = @device.to_s if @device.to_s == 'web'
  end

  def unset_app
    @req_source = nil
  end

  # def set_chewy_filter
  #   Chewy.settings = {prefix: ActsAsTenant.current_tenant.internal_name}
  # end
end
