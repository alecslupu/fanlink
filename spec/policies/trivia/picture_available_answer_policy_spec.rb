# frozen_string_literal: true
require "spec_helper"

RSpec.describe Trivia::PictureAvailableAnswerPolicy, type: :policy do
  args = [ Trivia::PictureAvailableAnswer, "trivia" ]
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context "Scope" do
    it "should only return the person quiz in current product" do
      person = build(:person)

      post2 = ActsAsTenant.with_tenant(create(:product)) { create(:trivia_picture_available_answer) }

      ActsAsTenant.with_tenant(person.product) do
        post = create(:trivia_picture_available_answer)
        scope = Pundit.policy_scope!(person, Trivia::PictureAvailableAnswer)
        expect(scope.count).to eq(1)
        expect(scope).to include(post)
        expect(scope).not_to include(post2)
      end
    end
  end
end
