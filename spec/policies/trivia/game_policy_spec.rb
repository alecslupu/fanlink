# frozen_string_literal: true

RSpec.describe Trivia::GamePolicy, type: :policy do
  args = [ Trivia::Game, "trivia" ]
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args

  let(:master_class) { Trivia::Game.new }

  context "logged in admin with generate game permission" do
    permission_list = {
      index: false,
      show: false,
      create: false,
      new: false,
      update: false,
      edit: false,
      destroy: false,
      export: false,
      history: false,
      show_in_app: false,
      select_product: false,
      generate_game_action: true
    }

    before :each do
      allow_any_instance_of(Person).to receive(:individual_access).and_return(PortalAccess.new(trivia_generate_game_action: true))
    end

    subject { described_class.new(Person.new, master_class) }

    describe "permissions" do
      permission_list.each do |policy, value|
        if value
          it { is_expected.to permit_action(policy) }
        else
          it { is_expected.to forbid_action(policy) }
        end
      end
    end
    describe "protected methods" do
      it { expect(subject.send(:super_admin?)).to eq(false) }
      it { expect(subject.send(:has_permission?, "bogous")).to eq(false) }
      it { expect(subject.send(:has_permission?, "index")).to eq(false) }
    end
  end

  context "Scope" do
    it "should only return the person quiz in current product" do
      person = create(:person)

      post2 = ActsAsTenant.with_tenant(create(:product)) { create(:trivia_game) }

      ActsAsTenant.with_tenant(person.product) do
        post = create(:trivia_game)
        scope = Pundit.policy_scope!(person, Trivia::Game)
        expect(scope.count).to eq(1)
        expect(scope).to include(post)
        expect(scope).not_to include(post2)
      end
    end
  end
end
