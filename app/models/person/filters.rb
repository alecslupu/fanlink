class Person
  extend ActiveSupport::Concern

  module Filters
    def self.included(base)
      base.class_exec do
        scope :username_filter, -> (query) { where( "people.username_canonical ilike ?", "%#{query}%") }
        scope :email_filter,    -> (query) { where( "people.email ilike ?", "%#{query}%") }
      end
    end
  end
end