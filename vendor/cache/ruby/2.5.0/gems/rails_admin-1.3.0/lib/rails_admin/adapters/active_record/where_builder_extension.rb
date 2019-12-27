require 'rails_admin/adapters/active_record'

module RailsAdmin::Adapters::ActiveRecord
  module WhereBuilderExtension
    def initialize(scope)
      @includes = []
      super(scope)
    end

    def add(field, value, operator)
      @includes.push(field.name) if field.association?
      super(field, value, operator)
    end

    def build
      @includes.any? ? super.includes(*(@includes.uniq)) : super
    end
  end

  class WhereBuilder
    prepend WhereBuilderExtension
  end
end
