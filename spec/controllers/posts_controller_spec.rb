# frozen_string_literal: true
RSpec.describe PostsController, type: :controller do
  describe 'GET share' do
    it 'returns the record' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post = create(:published_post, person: person)
        login_as(person)

        get :share, params: {
          post_id: post.id,
          product: post.product.internal_name
        }

        expect(response).to be_successful
        expect(response).to render_template('share')
      end
    end
  end
end
