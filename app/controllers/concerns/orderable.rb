# frozen_string_literal: true

# Adapted from https://gist.github.com/mamantoha/9c0aec7958c7636cebef
module Orderable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  # A list of the param names that can be used for ordering the model list
  def ordering_params(params)
    # For example it retrieves a list of experiences in descending order of price.
    # Within a specific price, older experiences are ordered first
    #
    # GET /api/v1/experiences?sort=-price,created_at
    # ordering_params(params) # => { price: :desc, created_at: :asc }
    # Experience.order(price: :desc, created_at: :asc)
    #
    ordering = {}
    if params[:sortBy]
      sort_order = { 'asc' => :asc, 'desc' => :desc }
      sort_sign = 'asc'
      if params.has_key?(:descending) && params[:descending]
        sort_sign = 'desc'
      end
      model = controller_name.classify.constantize
      if model.attribute_names.include?(params[:sortBy])
        ordering[params[:sortBy]] = sort_order[sort_sign]
      end
    end
    ordering
  end
end
