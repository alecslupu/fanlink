require "rails/generators/named_base"
require "rails/generators/resource_helpers"
require_relative "../generator_helpers"

module Fanlink
  class ControllerGenerator < Rails::Generators::NamedBase
    include Rails::Generators::ResourceHelpers
    include Fanlink::GeneratorHelpers

    source_root File.expand_path("../templates", __FILE__)

    def create_root_folder
      path = File.join("app/controllers", api_path)
      empty_directory path unless File.directory?(path)
    end

    def copy_controller_file
      filename = filename_with_extensions("controller")
      template filename, File.join("app/controllers", api_path, "#{controller_file_name.pluralize}_controller.rb")
    end

    # argument :name, :type => :string
    # class_option :version, type: :string, default: 'V1', desc: "API Version"
  end
end
