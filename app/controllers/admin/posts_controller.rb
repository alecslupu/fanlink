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

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Post.
    #     page(params[:page]).
    #     per(10)
    # end
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

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Post.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  # private
  #

       #     body_params = []
  #     Post::LANGS.keys.each do |l|
  #       body_params << "body_#{l}".to_sym
  #     end
  #     permitted = [:global, :starts_at, :ends_at, :repost_interval, :status, :body_un, :body_es]
  #     Rails.logger.debug(permitted)
  #     params.require(:post).permit(permitted)
  #   end
  end
end
