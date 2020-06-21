# frozen_string_literal: true

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
    false
  end

  def dashboard?
    true
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
    user.full_permission_list.include?([module_name, permission].join('_').delete_suffix('?').to_sym)
  end

  def super_admin?
    user.super_admin?
  end

  def module_name
    Rails.logger.debug("Defaulting to #{self.class.name}")
    'admin'
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
