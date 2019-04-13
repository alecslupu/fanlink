require "rails/generators/named_base"
require "rails/generators/resource_helpers"
require_relative "../generator_helpers"

module Fanlink
  class JbuilderGenerator < Rails::Generators::Base
    include Rails::Generators::ResourceHelpers
    include Fanlink::GeneratorHelpers

    source_root File.expand_path("../templates", __FILE__)
  end
end
