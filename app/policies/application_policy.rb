class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    # true
    false
  end


  def show?
    # true
    false
  end

  def create?
    # true
    false
  end

  def new?
    create?
  end

  def update?
    # true
    false
  end

  def edit?
    update?
  end

  def destroy?
    # false
    false
  end

  # Rails_admin
  #
  def export?
    # true
    false
  end

  def show_in_app?
    # false
    false
  end

  def history?
    # true
    false
  end

  def dashboard?
    user && user.some_admin?
  end

  def select_product_dashboard?
    # true
    false
  end
  def generate_game_action?
    # false
    false
  end
  # Rails admin

  def select_product?
    user && user.super_admin? && user.product.internal_name == "admin"
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
