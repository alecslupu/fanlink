# frozen_string_literal: true
# because https://github.com/thoughtbot/paperclip/issues/2484
Aws::VERSION = Gem.loaded_specs["aws-sdk"].version
