# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StringConfigItemPolicy, type: :policy do
  args = StringConfigItem, 'root'
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

end
