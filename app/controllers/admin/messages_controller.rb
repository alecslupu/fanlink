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
      page = Administrate::Page::Collection.new(dashboard, order: order)
      params[:filterrific] ||= {}
      if params[:order].present?
        params[:filterrific][:sorted_by] = "#{params[:order]} #{params[:direction]}"
      end
      @filterrific = initialize_filterrific(
        Message.publics.for_product(ActsAsTenant.current_tenant),
        params[:filterrific],
        select_options: {
          with_reported_status: Message::FilterrificImpl.options_for_reported_status_filter
        }
      ) or return
      resources = @filterrific.find.page(params[:page])
      render locals: {
          resources: resources,
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
