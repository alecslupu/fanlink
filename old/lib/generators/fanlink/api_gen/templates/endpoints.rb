class Add<%= singular_name %>Endpoints < Apigen::Migration
  def up
    add_endpoint <%= ":get_#{plural_name}" %> do
      method :get
      tag <%= singular_name %>
      path <%= "\"/#{plural_name}\"" %>
      description <%= "\"Get #{plural_name.split('_').map(&:capitalize).join(' ')}\"" %>
      output :success do
        status 200
        type :object do
          <%= plural_name %> :array do
            type :<%= singular_name %>_response
          end
        end
      end
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
      end
      output :server_error do
        status 500
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated."
      end
    end

    add_endpoint <%= ":get_a_#{singular_name}" %> do
      method :get
      tag <%= singular_name %>
      path <%= "\"/#{plural_name}/{id}\"" %> do
        id :int32
      end
      description <%= "\"Get a #{singular_name.split('_').map(&:capitalize).join(' ')}\"" %>
      output :success do
        status 200
        type :object do
          <%= singular_name %> :<%= singular_name %>_response
        end
      end
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
      end
      output :not_found do
        status 404
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "The record was not found."
      end
      output :server_error do
        status 500
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated."
      end
    end

    add_endpoint <%= ":create_a_#{singular_name}" %> do
      method :post
      tag <%= singular_name %>
      path <%= "\"/#{plural_name}\"" %>
      description <%= "\"Create a #{singular_name.split('_').map(&:capitalize).join(' ')}\"" %>
      input do
        type :object do
          <%= singular_name %> :object do
          <%- editable_attributes.each do |attr| -%>
          <%- case attr.type.to_s
          when "integer" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:int32).explain do
              description ""
              example ""
            end
          <%- when "text" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:string).explain do
              description ""
              example ""
            end
          <%- when "jsonb" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:string).explain do
              description ""
              example ""
            end
          <%- else -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:<%= attr.type %>).explain do
              description ""
              example ""
            end
        <%- end -%>
        <%- end -%>
          end
        end
      end
      output :success do
        status 200
        type :object do
          <%= singular_name %> :<%= singular_name %>_response
        end
      end
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
      end
      output :not_found do
        status 404
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "The record was not found."
      end
      output :unprocessible do
        status 422
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "One or more fields were invalid. Check response for reasons."
      end
      output :rate_limit do
        status 429
        type :string
        description "Not enough time since last submission of this action type or duplicate action type, person, identifier combination."
      end
      output :server_error do
        status 500
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated."
      end
    end

    add_endpoint <%= ":update_a_#{singular_name}" %> do
      method :put
      tag <%= singular_name %>
      path <%= "\"/#{plural_name}/{id}\"" %> do
        id :int32
      end
      description <%= "\"Update a #{singular_name.split('_').map(&:capitalize).join(' ')}\"" %>
      input do
        type :object do
          <%= singular_name %> :object do
          <%- editable_attributes.each do |attr| -%>
          <%- case attr.type.to_s
          when "integer" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:int32).explain do
              description ""
              example ""
            end
          <%- when "text" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:string).explain do
              description ""
              example ""
            end
          <%- when "jsonb" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:string).explain do
              description ""
              example ""
            end
          <%- when "datetime" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:string).explain do
              description ""
              example ""
            end
          <%- when "date" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:string).explain do
              description ""
              example ""
            end
          <%- when "boolean" -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:bool).explain do
              description ""
              example ""
            end
          <%- else -%>
            <%= ((attr.attr_options[:required?].to_s == "false") ? "#{attr.name}?" : attr.name) %>(:<%= attr.type %>).explain do
              description ""
              example ""
            end
          <%- end -%>
          <%- end -%>
          end
        end
      end
      output :success do
        status 200
        type :object do
          <%= singular_name %> :<%= singular_name %>_response
        end
      end
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
      end
      output :not_found do
        status 404
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "The record was not found."
      end
      output :unprocessible do
        status 422
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "One or more fields were invalid. Check response for reasons."
      end
      output :server_error do
        status 500
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated."
      end
    end

    add_endpoint <%= ":destroy_a_#{singular_name}" %> do
      method :delete
      tag <%= singular_name %>
      path <%= "\"/#{plural_name}/{id}\"" %> do
        id :int32
      end
      description <%= "\"Destroy a #{singular_name.split('_').map(&:capitalize).join(' ')}\"" %>
      output :success do
        status 200
        type :void
      end
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
      end
      output :not_found do
        status 404
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "The record was not found."
      end
      output :unprocessible do
        status 422
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "One or more fields were invalid. Check response for reasons."
      end
      output :server_error do
        status 500
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated."
      end
    end
  end
end