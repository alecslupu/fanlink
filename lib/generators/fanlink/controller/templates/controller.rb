class <%= "#{controller_class_name}Controller" %> < <%= "#{api_module_path}::BaseController" %>
  load_up_the <%= singular_name.camelize %>, only: %i[ update show destroy ]

  def index
    @<%= plural_name %> = paginate(<%= singular_name.camelize %>.all)
  end

  def show
    return_the @<%= singular_name %>
  end

  def create
    @<%= singular_name %> = <%= singular_name.camelize %>.create(<%= singular_name %>_params)
    if @<%= singular_name %>.valid?
      broadcast(:<%= singular_name %>_created, current_user, @<%= singular_name %>)
      return_the @<%= singular_name %>
    else
      render_422(@<%= singular_name %>.errors)
    end
  end

  def update
    if @<%= singular_name %>.update(<%= singular_name %>_params)
      broadcast(:<%= singular_name %>_updated, current_user, @<%= singular_name %>)
      return_the @<%= singular_name %>
    else
      render_422(@<%= singular_name %>.errors)
    end
  end

  def destroy
    if current_user.some_admin?
      if @<%= singular_name %>.update(deleted: true)
        head :ok
      else
        render_422(@<%= singular_name %>.errors)
      end
    else
      render_not_found
    end
  end

  private

  def <%= singular_name %>_params
    params.require(:<%= singular_name %>).permit(<%= editable_attributes.map { |a| a.name.dup.prepend(':') }.join(', ') %>)
  end
end
