# frozen_string_literal: true

require 'spec_helper'


RSpec.describe Trivia::AvailableAnswerPolicy, type: :policy do

  args = [ Trivia::AvailableAnswer, 'trivia' ]
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context 'Scope' do
    it 'should only return the person quiz in current product' do
      person = build(:person)

      post2 = ActsAsTenant.with_tenant(create(:product)) { create(:trivia_available_answer) }

      ActsAsTenant.with_tenant(person.product) do
        post = create(:trivia_available_question)
        scope = Pundit.policy_scope!(person, Trivia::AvailableAnswer)
        post.available_answers.each do |a|
          expect(scope).to include(a)
        end
        expect(scope).not_to include(post2)
      end
    end
  end
end
