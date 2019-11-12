class RolePolicy < ApplicationPolicy

  def attributes_for(action)
    {}
  end

  protected
  def module_name
    Rails.logger.debug("Defaulting to #{self.class.name}")

    "root"
  end
end
