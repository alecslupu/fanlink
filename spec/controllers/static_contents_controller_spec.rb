RSpec.describe Api::V4::StaticContentsController, type: :controller do
  before do
    @json = nil
    @api_version = nil
  end

  describe 'GET show' do
    it 'returns the record' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        static_content = create(:static_content)
        login_as(person)

        get :show, params: {
          product_id: static_content.product.id,
          slug: static_content.slug
        }

        expect(response).to be_successful
        expect(response).to render_template('show')
      end
    end
  end
end
