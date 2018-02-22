module Admin
  class ActionTypesController < Admin::ApplicationController
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

    def destroy
      if requested_resource.destroy
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:alert] = requested_resource.errors.full_messages.first
      end
      redirect_to action: :index
    end

  private

    def valid_action?(name, resource = resource_class, action_type = nil)
      name == "index" || (current_user.super_admin? && (action_type.nil? || !action_type.in_use?))
    end
  end
end
