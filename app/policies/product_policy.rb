class ProductPolicy < ApplicationPolicy

  def show?
    raise "not implemented"
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if "admin" == user.product.internal_name
        scope.all
      else
        super.where(id: user.product_id)
      end
    end
  end
end
