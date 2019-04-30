class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # Rails_admin
  #
  def export?
    true
  end

  def show_in_app?
    false
  end

  def history?
    true
  end

  def dashboard?
    true
  end

  def select_product_dashboard?
    true
  end
  # Rails admin

  def select_product?
    user && user.super_admin? && user.product.internal_name == 'admin'
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.some_admin? && scope.respond_to?(:product)
        scope.where(product_id: ActsAsTenant.current_tenant.id)
      else
        scope.all
      end
    end
  end
end
