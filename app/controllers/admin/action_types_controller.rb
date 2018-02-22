module Admin
  class ActionTypesController < Admin::ApplicationController
    def valid_action?(name, resource = resource_class)
      name == "index" || current_user.super_admin?
    end

    def index
      #search_term = params[:search].to_s.strip
      resources = ActionType.unscoped.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)
      render locals: {
          resources: resources,
          #search_term: search_term,
          page: page,
          show_search_bar: false
      }
    end

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = ActionType.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   ActionType.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
