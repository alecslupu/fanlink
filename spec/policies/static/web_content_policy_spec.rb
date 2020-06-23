# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Static::WebContentPolicy, type: :policy do
  args = [Static::WebContent, 'root']
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args
end
