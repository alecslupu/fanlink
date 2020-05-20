# frozen_string_literal: true
class ApplicationRecord < ActiveRecord::Base
  include Wisper::Publisher
  self.abstract_class = true

  DATETIME_FORMAT = "%m/%d/%Y %H:%M:%S"

  def created
    created_at.strftime(DATETIME_FORMAT)
  end

  def updated
    updated_at.strftime(DATETIME_FORMAT)
  end
end
