class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  DATETIME_FORMAT = "%m/%d/%Y %H:%M:%S"

  def created
    created_at.strftime(DATETIME_FORMAT)
  end

  def updated
    updated_at.strftime(DATETIME_FORMAT)
  end

end
