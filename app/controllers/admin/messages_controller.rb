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

    def hide
      @message = Message.find(params[:message_id])
      if @message.visible?
        @message.update_attribute(:hidden, true)
        delete_message(@message)
        @message.message_reports.each do |report|
          report.message_hidden!
        end
      end
    end

    def index
      #search_term = params[:search].to_s.strip
      resources = Message.publics.for_product(ActsAsTenant.current_tenant).order(created_at: :desc).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
          resources: resources,
          #search_term: search_term,
          page: page,
          show_search_bar: false
      }
    end

    def unhide
      @message = Message.find(params[:message_id])
      if @message.hidden?
        @message.update_attribute(:hidden, false)
        @message.message_reports.each do |report|
          report.pending!
        end
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
