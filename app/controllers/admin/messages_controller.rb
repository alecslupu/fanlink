module Admin
  class MessagesController < Admin::ApplicationController
    include Messaging

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Message.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Message.find_by!(slug: param)
    # end

    def index
      #search_term = params[:search].to_s.strip
      resources = Message.for_product(ActsAsTenant.current_tenant).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        #search_term: search_term,
        page: page,
        show_search_bar: false
      }
    end

    def hide
      @message = Message.find(params[:message_id])
      if @message.visible?
        @message.update_attribute(:hidden, true)
        delete_message(@message)
      end
    end

    def unhide
      @message = Message.find(params[:message_id])
      if @message.hidden?
        @message.update_attribute(:hidden, false)
      end
    end

  private

    def message_params
      params.require(:message).permit(:hidden)
    end

    def valid_action?(name, resource = resource_class)
      %w[edit new destroy].exclude?(name.to_s) && super
    end
  end
end
