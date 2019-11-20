require "rails/generators/named_base"
require "rails/generators/resource_helpers"
require_relative "../generator_helpers"

module Fanlink
  class ApiGenGenerator < Rails::Generators::NamedBase
    include Rails::Generators::ResourceHelpers
    include Fanlink::GeneratorHelpers

    source_root File.expand_path("../templates", __FILE__)

    argument :attributes, type: :array, default: [], banner: "field:type field:type"
    class_option :version, type: :string, default: "V1", desc: "API Version"

    def create_root_folder
      path = File.join("docs/apigen", options.version, controller_file_path)
      empty_directory path unless File.directory?(path)
    end

    def copy_view_files
      %w(endpoints responses).each do |view|
        filename = filename_with_extensions(view)
        template filename, File.join("docs/apigen", options.version, controller_file_path, "#{singular_name}_#{filename}")
      end
    end
  end
end
