class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    has_permission? :read?
  end

  def show?
    has_permission? :read?
  end

  def create?
    has_permission? :update?
  end

  def new?
    create?
  end

  def update?
    has_permission? __method__
  end

  def edit?
    update?
  end

  def destroy?
    has_permission? :delete?
  end

  # Rails_admin
  #
  def export?
    has_permission? __method__
  end

  def history?
    has_permission? __method__
  end

  def show_in_app?
    # false
    false
  end

  def dashboard?
    user && user.some_admin?
  end

  # def select_product_dashboard?
  #   # true
  #   false
  # end

  # def generate_game_action?
  #   # false
  #   false
  # end
  # Rails admin

  def select_product?
    super_admin?
  end

  protected

  def has_permission?(permission)
    has_systen_permission?(permission) || has_role_permission?(permission) || has_individual_permission?(permission)
  end

  def has_role_permission?(permission)
    begin
      user.role.send([module_name, permission].join("_").to_sym)
    rescue
      false
    end
  end

  def has_systen_permission?(permission)
    begin
      super_admin?
    rescue
      false
    end
  end

  def has_individual_permission?(permission)
    begin
      access.send([module_name, permission].join("_").to_sym)
    rescue
      false
    end
  end

  def super_admin?
    user && user.super_admin? && user.product.internal_name == "admin"
  end

  def module_name
    Rails.logger.debug("Defaulting to #{self.class.name}")
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
      scope.all
    end
  end
end
