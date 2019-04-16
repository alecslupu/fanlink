require "rails/generators/named_base"
require "rails/generators/resource_helpers"
require "lib/generators/fanlink/generator_helpers"

module Fanlink
  class ListnerGenerator < Rails::Generators::Base
    include Rails::Generators::ResourceHelpers
    include Fanlink::GeneratorHelpers

    source_root File.expand_path("../templates", __FILE__)
    argument :name, type: :string
  end
end
