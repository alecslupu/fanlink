# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FollowingPolicy, type: :policy do
  args = Following, 'user'

  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args
end
