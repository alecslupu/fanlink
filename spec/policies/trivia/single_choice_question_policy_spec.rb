# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Trivia::SingleChoiceQuestionPolicy, type: :policy do
  args = [Trivia::SingleChoiceQuestion, 'trivia']
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  context 'Scope' do
    it 'should only return the person quiz in current product' do
      person = create(:person)

      post2 = ActsAsTenant.with_tenant(create(:product)) { create(:trivia_single_choice_question) }

      ActsAsTenant.with_tenant(person.product) do
        post = create(:trivia_single_choice_question)
        scope = Pundit.policy_scope!(person, Trivia::SingleChoiceQuestion)
        post.round.questions.each do |q|
          expect(scope).to include(q)
        end
        expect(scope.count).to eq(post.round.questions.size)
        expect(scope).not_to include(post2)
      end
    end
  end
end
