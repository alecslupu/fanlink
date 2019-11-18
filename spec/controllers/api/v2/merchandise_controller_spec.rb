require "spec_helper"

RSpec.describe Api::V2::MerchandiseController, type: :controller do
  describe "POST create" do
    it "creates a merchandise with attachment when it's valid" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: {
          merchandise: {
            product_id: person.product.id,
            name: "A name",
            description: 'desc',
            price: 1,
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to have_http_status(200)
        expect(Merchandise.last.picture.exists?).to be_truthy
        expect(json['merchandise']['picture_url']).to include('better.png')
      end
    end
  end

  describe "PUT update" do
    it "updates a merchandise's attachment" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        merchandise = create(:merchandise)

        put :update, params: {
          id: merchandise.id,
          merchandise: {
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to have_http_status(200)
        expect(Merchandise.last.picture.exists?).to be_truthy
        expect(json['merchandise']['picture_url']).to include('better.png')
      end
    end
  end

  # TODO: auto-generated
  describe "DELETE destroy" do
    pending
  end

  describe 'GET index' do
    it 'returns all merchandises with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:merchandise, 3, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :index

        expect(response).to have_http_status(200)
        expect(json['merchandise'].size).to eq(3)
        json['merchandise'].each do |merchandise|
          expect(merchandise['picture_url']).not_to eq(nil)
        end
      end
    end
  end

  describe 'GET show' do
    it 'returns the merchandise with the attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        merchandise = create(:merchandise, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :show, params: { id: merchandise.id }
        expect(response).to have_http_status(200)

        expect(json['merchandise']['picture_url']).not_to eq(nil)
      end
    end
  end
end
