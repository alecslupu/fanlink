FanlinkApi::API.model :<%= singular_table_name %>_app_json do
  type :object do
    <%= singular_table_name %> :object do
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

FanlinkApi::API.model :<%= singular_table_name %>_portal_json do
  type :object do
    <%= singular_table_name %> :object do
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
