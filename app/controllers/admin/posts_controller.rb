module Admin
  class PostsController < Admin::ApplicationController
    def create
      resource = resource_class.new(resource_params)
      resource.person = current_user
      if resource.save
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
            page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def index
      #search_term = params[:search].to_s.strip
      resources = Post.for_product(ActsAsTenant.current_tenant).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)
      render locals: {
          resources: resources,
          #search_term: search_term,
          page: page,
          show_search_bar: false
      }
    end
  end
end
