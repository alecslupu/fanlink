module Fanlink
  module GeneratorHelpers
    attr_accessor :options, :attributes

    private

      def api_path
        api_path = controller_file_path.split("/").shift(2).join("/")
        api_path
      end

      def api_module_path
        controller_class_path.map!(&:camelize).join("::")
      end

      def model_exists?
        File.exist?("#{Rails.root}/app/models/#{singular_name}.rb")
      end

      def model_columns_for_attributes
        singular_name.camelize.constantize.columns.reject do |column|
          column.name.to_s =~ /^(.*_old|id|user_id|created_at|updated_at)/
        end
      end

      def model_columns_for_api
        singular_name.camelize.constantize.columns.reject do |column|
          column.name.to_s =~ /^(.*_old)$/
        end
      end

      def editable_attributes
        attributes ||= if model_exists?
          model_columns_for_attributes.map do |column|
            Rails::Generators::GeneratedAttribute.new(column.name.to_s, column.type.to_s, false, required?: !column.null)
          end
        else
          []
        end
      end

      def response_attributes
        attributes ||= if model_exists?
          model_columns_for_api.map do |column|
            Rails::Generators::GeneratedAttribute.new(column.name.to_s, column.type.to_s, false, required?: !column.null)
          end
        else
          []
        end
      end

      def field_to_check_update
        @field_update_in_spec ||= if text_field = editable_attributes.find { |attr| attr.type == "string" }
          { name: text_field.name, old_value: "'Just Text'", new_value: "'New Text'" }
        elsif numeric_field = editable_attributes.find { |attr| attr.type == "integer" }
          { name: numeric_field.name, old_value: 1, new_value: 2 }
        else
          false
        end
      end

      def all_actions
        actions = %w(index show create edit update destroy)
        actions
      end

      def view_files
        actions = %w(index create update partial)
        actions
      end

      def controller_methods(dir_name)
        all_actions.map do |action|
          read_template("#{dir_name}/#{action}.rb")
        end.join("\n").strip
      end

      def source_path(relative_path)
        File.expand_path(File.join("../templates/", relative_path), __FILE__)
      end

      def read_template(relative_path)
        ERB.new(File.read(source_path(relative_path)), nil, "-").result(binding)
      end

      def attributes_names
        [:id] + super
      end

      def filename_with_extensions(name)
        [name, :rb] * "."
      end

      def attributes_list_with_timestamps
        attributes_list(attributes_names + %w(created_at updated_at))
      end

      def attributes_list(attributes = attributes_names)
        if self.attributes.any? { |attr| attr.name == "password" && attr.type == :digest }
          attributes = attributes.reject { |name| %w(password password_confirmation).include? name }
        end

        attributes.map { |a| ":#{a}" } * ", "
      end
  end
end
