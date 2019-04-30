module Admin
  class RoomsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Room.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Room.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def create
      params[:room] = params[:room].merge(public: true, created_by_id: current_user.id, product_id: ActsAsTenant.current_tenant.id)
      super
    end

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource.where(public: true),
                                           dashboard_class,
                                           search_term).run
      resources = apply_resource_includes(resources)
      resources = order.apply(resources)
      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
          resources: resources,
          search_term: search_term,
          page: page,
          show_search_bar: show_search_bar?
      }
    end

  private

    def resource_params
      params.require(:room).permit((dashboard.permitted_attributes << %i[ public created_by_id product_id ]).flatten)
    end
  end
end
