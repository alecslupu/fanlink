# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("PostCommentReport")

  config.model "PostCommentReport" do
    parent "PostComment"

    list do
      scopes [:pending, nil, :comment_hidden, :no_action_needed]
    end
  end
end
