require 'open_api/generator'

# Usage: add `include AutoGenDoc` to your base controller.
module AutoGenDoc
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def inherited(subclass)
      super
      subclass.class_eval do
        break unless self.name.match?(/sController|sDoc/)
        route_base self.name.sub("::Docs", '').sub('Doc', '').underscore.downcase.gsub('::', '/') if self.name.match?(/sDoc/)
        #puts self.name.sub("::Docs", '').sub('Doc', '').underscore.downcase.gsub('::', '/') if self.name.match?(/sDoc/)
        open_api_dry
      end
    end

    private

    def open_api_dry
      route_base = try(:controller_path) || instance_variable_get('@route_base')
      ::OpenApi::Generator.get_actions_by_route_base(route_base)&.each do |action|
        api_dry action do
          version = route_base.split('/')[1]
          model = Object.const_get(action_path.split('#').first.split('/').last[0..-2].camelize) rescue nil
          model.connection if !model.nil?
          #puts model.inspect
          @type = String

          header! 'Accept', String, desc: "application/vnd.api.#{version}+json"

          if %w[ index list ].include?(action)
            query :page, Integer, desc: 'page, greater than 1', range: { ge: 1 }, dft: 1
            query :per_page, Integer, desc: 'data count per page',  range: { ge: 1 }, dft: 25
            @type = Array[load_schema(model)]
            response '404', 'Not Found. If the error says a route is missing, it usually means you forgot the ACCEPT header.'
          end

          if %w[ show destroy update ].include?(action)
            path! :id, Integer, desc: 'id'
            response '404', 'Not Found. The database doesn\'t contain a record for that id. If the error says a route is missing, it usually means you forgot the ACCEPT header.'
          end

          if %w[ create update show ].include?(action)
            @type = load_schema(model)
          end

          if %w[ create update ].include?(action)
            response '422', 'Unprocessable Entity. Usually occurs when a field is invalid or missing.'
          end

          # Common :destroy parameters
          if action == 'destroy'
            response_ref 200 => :OK
          end

          # Common :update parameters
          if action == 'update'
            #path! :id, Integer, desc: 'id'
          end

          ### Common responses
          # OAS require at least one response on each api.
          # default_response 'default response', :json
          #puts @type.inspect
          # response '200', 'success', :json, data: {
          #     code: { type: Integer, dft: 200 },
          #      msg: { type: String,  dft: 'success' },
          #     data: { type: @type }
          # }


          ### Automatically generate responses based on the agreed error class.
          #   The business error-class's implementation see:
          #     https://github.com/zhandao/zero-rails/blob/master/lib/business_error/dsl.rb
          #   It's usage see:
          #     https://github.com/zhandao/zero-rails/blob/master/app/_docs/api_error.rb
          #   Then, the following code will auto generate error responses by
          #     extracting the specified error classes info, for example,
          #     in ExamplesError: `mattr_reader :name_not_found, 'can not find the name', 404`
          #     will generate: `"404": { "description": "can not find the name" }`
          ###
          # # api/v1/examples#index => ExamplesError
          # error_class_name = action_path.split('#').first.split('/').last.camelize.concat('Error')
          # error_class = Object.const_get(error_class_name) rescue next
          # cur_api_errs = error_class.errors.values_at(action.to_sym, :private, :_public).flatten.compact.uniq
          # cur_api_errs.each do |error|
          #   info = error_class.send(error, :info)
          #   response info[:code], info[:msg]
          # end
          if !%w[ share forgot_password ].include?(action) || !route_base.split('/').include?('session') || (route_base.split('/').include?('people') && action != 'create')
            response '401', 'Unauthorized. '
          end
          response '500', 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
        end
      end
    end
  end
end
