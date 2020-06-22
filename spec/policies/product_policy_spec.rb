# frozen_string_literal: true


require 'spec_helper'

RSpec.describe ProductPolicy, type: :policy do
  args = Product, 'admin'
  include_examples 'enforces the permissions', args
  include_examples 'enforces the read permission', args
  include_examples 'enforces the update permission', args
  include_examples 'enforces the delete permission', args
  include_examples 'enforces the history permission', args
  include_examples 'enforces the export permission', args


  context 'scope' do
    describe 'when the product is admin' do
      it 'should return all the products' do
        ActsAsTenant.without_tenant do
          admin_product = create(:product, internal_name: 'admin')
          another_product = create(:product, internal_name: 'not_admin')
          person = create(:person, product: admin_product)
          create(:person, product: another_product)
          scope = Pundit.policy_scope!(person, Product)
          expect(scope).to include(admin_product)
          expect(scope).to include(another_product)
        end
      end
    end

    describe 'when the product is not admin' do
      it "should return only the user's product" do
        admin_product = create(:product, internal_name: 'admin')
        another_product = create(:product, internal_name: 'not_admin')
        person = create(:person, product: another_product)
        ActsAsTenant.with_tenant(person.product) do
          scope = Pundit.policy_scope!(person, Product)
          expect(scope.count).to eq(1)
        end
      end
    end
  end
end

