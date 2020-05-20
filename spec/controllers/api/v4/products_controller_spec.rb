# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V4::ProductsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    it 'returns all products with their attached image' do
      allow(Product).to receive(:all).and_return build_list(:product, 3,
                                                            logo: fixture_file_upload('images/better.png', 'image/png'))
      get :index

      expect(response).to be_successful
      expect(json['products'].size).to eq(3)
      json['products'].each do |product|
       expect(product['logo_file_size']).not_to be_nil
      end
    end
  end

  # TODO: auto-generated
  describe "GET show" do
    it 'returns the product with the attached image' do
      product = create(:product, logo: fixture_file_upload('images/better.png', 'image/png'))
      # allow(Product).to receive(:find).with("1").and_return product
      get :show, params: { id: product.id }

      # expect(response.body).to eq("")
      expect(response).to be_successful
      expect(json['product']['logo_file_size']).not_to be_nil
    end
  end

  # TODO: auto-generated
  describe "POST create" do
    # it "creates a product with attachment when it's valid" do
    #   post :create, params:{
    #     product: {
    #       internal_name: "Iname",
    #       name: "Name",
    #       enabled: true,
    #       logo: fixture_file_upload('images/better.png', 'image/png')
    #     }
    #   }
    #   expect(response).to be_successful
    #   expect(Product.last.logo.exists?).to be_truthy
    #   expect(json['product']['logo_file_size']).not_to eq(nil)
    # end
  end

  # TODO: auto-generated
  describe "PUT update" do
    # it "updates a products's attachment" do
    #   product = create(:product)

    #   put :update, params: {
    #     id: product.id,
    #     product: {
    #       logo: fixture_file_upload('images/better.png', 'image/png')
    #     }
    #   }

    #   expect(response).to be_successful
    #   expect(Product.last.logo.exists?).to be_truthy
    #   expect(json['product']['logo_file_size']).not_to eq(nil)
    # end
  end
end
