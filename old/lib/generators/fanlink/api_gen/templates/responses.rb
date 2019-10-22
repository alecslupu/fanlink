class Add<%= singular_table_name %>JsonResponse < Apigen::Migration
  def up
    add_model :<%= singular_table_name %>_response do
      type :object do
        <%- response_attributes.each do |attr| -%>
        <%- case attr.type.to_s
        when "integer" -%>
          <%= attr.name %> :int32
        <%- when "text" -%>
          <%= attr.name %> :string
        <%- when "jsonb" -%>
          <%= attr.name %> :object
        <%- when "boolean" -%>
          <%= attr.name %> :bool
        <%- else -%>
          <%= attr.name %> :<%= attr.type %>
        <%- end -%>
        <%- end -%>
      end
    end
  end
end