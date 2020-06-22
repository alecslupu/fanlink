# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::Courseware::WishlistController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/courseware/wishlists' do
    get '' do

      security [Bearer: []]
      tags 'Courseware'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 25
      let(:person) { create(:person) }
      let(:Authorization) { '' }

      response '200', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/CertificateWishlist'
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end

    post '' do
      security [Bearer: []]
      tags 'Courseware'
      parameter name: :certificate_id, in: :formData, type: :string
      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      let(:Authorization) { '' }

      let(:person) { create(:person) }
      let(:certificate) { create(:certificate) }
      let(:certificate_id) { certificate.id }

      response '200', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end

      response '404', 'Not found' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:certificate_id) { Time.zone.now.to_i }
        run_test!
      end

      response '422', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let!(:wishlist) { create(:courseware_wishlist_wishlist, person: person, certificate: certificate) }

        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end

  path '/courseware/wishlists/{id}' do
    delete '' do
      security [Bearer: []]
      tags 'Courseware'
      parameter name: :id, in: :path, type: :string

      let(:Authorization) { '' }
      let(:wishlist) { create(:courseware_wishlist_wishlist) }
      let(:id) { 0 }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      response '200', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: wishlist.person.id)}" }
        let(:id) { wishlist.certificate_id }
        run_test!
      end

      response '404', 'Not found' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: wishlist.person.id)}" }
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end
