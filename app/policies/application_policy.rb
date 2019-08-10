class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    super_admin? || access.send([module_name, "read?"].join("_").to_sym)
  end

  def show?
    super_admin? || access.send([module_name, "read?"].join("_").to_sym)
  end

  def create?
    super_admin? || access.send([module_name, "create?"].join("_").to_sym)
  end

  def new?
    create?
  end

  def update?
    super_admin? || access.send([module_name, "update?"].join("_").to_sym)
  end

  def edit?
    super_admin? || access.send([module_name, "update?"].join("_").to_sym)
  end

  def destroy?
    super_admin? || access.send([module_name, "delete?"].join("_").to_sym)
  end

  # Rails_admin
  #
  def export?
    super_admin? || access.send([module_name, "export?"].join("_").to_sym)
  end

  def history?
    super_admin? || access.send([module_name, "history?"].join("_").to_sym)
  end

  def show_in_app?
    # false
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
    super_admin?
  end

  protected
  def super_admin?
    user && user.super_admin? && user.product.internal_name == "admin"
  end

  def module_name
    Rails.logger.debug("Defaulting to #{__CLASS__}")
    "admin"
  end

  def access
    @portal ||= PortalAccess.where(person_id: user.id).first_or_initialize
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
