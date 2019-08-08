class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    access.send([module_name, "read?"].join("_").to_sym) rescue false
  end

  def show?
    access.send([module_name, "read?"].join("_").to_sym) rescue false
  end

  def create?
    access.send([module_name, "create?"].join("_").to_sym) rescue false
  end

  def new?
    create?
  end

  def update?
    access.send([module_name, "update?"].join("_").to_sym) rescue false
  end

  def edit?
    access.send([module_name, "update?"].join("_").to_sym) rescue false
  end

  def destroy?
    access.send([module_name, "delete?"].join("_").to_sym) rescue false
  end

  # Rails_admin
  #
  def export?
    access.send([module_name, "export?"].join("_").to_sym) rescue false
  end

  def history?
    access.send([module_name, "history?"].join("_").to_sym) rescue false
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
    user && user.super_admin? && user.product.internal_name == "admin"
  end

  protected

  def module_name
    raise "Not implemented - #{self.class.name}"
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
