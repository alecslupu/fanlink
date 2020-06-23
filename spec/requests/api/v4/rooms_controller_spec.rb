# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::RoomsController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/rooms' do
    post '' do
      security [Bearer: []]
      tags 'Rooms' # 'kotlin']

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :"room[name]", in: :formData, type: :string, required: false
      parameter name: :"room[picture]", in: :formData, type: :file, required: false
      parameter name: :"room[member_ids][]", in: :formData, type: :array, required: false
      let(:Authorization) { '' }

      let(:message) { create(:message, room: create(:private_active_room)) }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        let('room[name]') { 'Room name' }
        let('room[member_ids][]') { create(:person).id }
        let('room[member_ids][]') { create(:person).id }
        schema "$ref": '#/definitions/RoomsObject'
        run_test!
      end
      response '400', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '422', '' do
        let('room[picture]') { fixture_file_upload('images/better.png', 'image/png') }

        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }

        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end

    get '' do
      security [Bearer: []]
      tags 'Rooms' # 'kotlin']
      parameter name: :"private",
                in: :query, type: :string, required: false
      let(:Authorization) { '' }

      let(:message) { create(:message, room: create(:private_active_room)) }
      let(:room) { message.room }
      # let(:id) { room.id }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      context 'all rooms' do
        response '200', 'HTTP/1.1 200 Ok' do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }

          schema "$ref": '#/definitions/RoomsArray'
          run_test!
        end
        response '401', '' do
          run_test!
        end
        response 500, 'Internal server error' do
          document_response_without_test!
        end
      end
      context 'private rooms' do
        let(:private) { true }
        response '200', 'HTTP/1.1 200 Ok' do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }

          schema "$ref": '#/definitions/RoomsArray'
          run_test!
        end
        response '401', '' do
          run_test!
        end
        response 500, 'Internal server error' do
          document_response_without_test!
        end
      end
    end
  end

  path '/rooms/{id}' do
    patch '' do
      security [Bearer: []]
      tags 'Rooms' # 'android-old']
      parameter name: :id, in: :path, type: :string
      parameter name: :"room[name]", in: :formData, type: :string, required: false
      parameter name: :"room[picture]", in: :formData, type: :file, required: false
      parameter name: :"room[member_ids]", in: :formData, type: :array, required: false

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      let(:Authorization) { '' }
      let(:message) { create(:message, room: create(:private_active_room)) }
      let(:room) { message.room }
      let(:id) { room.id }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        schema "$ref": '#/definitions/RoomsObject'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }

        let(:id) { Time.zone.now.to_i }
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
    delete '' do
      security [Bearer: []]
      tags 'Rooms' # 'android-old']
      parameter name: :id, in: :path, type: :string

      let(:Authorization) { '' }

      let(:message) { create(:message, room: create(:public_active_room)) }
      let(:room) { message.room }
      let(:id) { room.id }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: room.created_by_id)}" }
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:id) { Time.zone.now.to_i }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end

  path '/rooms/{id}/messages' do
    get '' do
      security [Bearer: []]
      tags 'Messages' # 'android-old']
      parameter name: :id, in: :path, type: :string
      parameter name: :from_date,
                in: :query, type: :string, required: false
      parameter name: :to_date,
                in: :query, type: :string, required: false
      parameter name: :page,
                in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 1, minimum: 1
      parameter name: :per_page,
                in: :query, type: :integer, required: false, description: ' Lorem ipsum'
      parameter name: :pinned,
                in: :formData, type: :string, enum: [:yes, :no], description: ' Lorem ipsum', required: false

      let(:Authorization) { '' }

      let(:message) { create(:message, room: create(:public_active_room)) }
      let(:room) { message.room }
      let(:id) { room.id }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      context 'Date range' do
        response '200', 'HTTP/1.1 200 Ok' do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
          schema "$ref": '#/definitions/MessagesArray'
          run_test!
        end
        response '401', '' do
          run_test!
        end
        response '404', '' do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
          let(:id) { Time.zone.now.to_i }
          run_test!
        end
        response 500, 'Internal server error' do
          document_response_without_test!
        end
      end
      context 'all' do
        response '200', 'HTTP/1.1 200 Ok' do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
          schema "$ref": '#/definitions/MessagesArray'
          run_test!
        end
        response '401', '' do
          run_test!
        end
        response '404', '' do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
          let(:id) { Time.zone.now.to_i }
          run_test!
        end
        response 500, 'Internal server error' do
          document_response_without_test!
        end
      end
      context 'pinned' do
        response '200', 'HTTP/1.1 200 Ok' do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
          schema "$ref": '#/definitions/MessagesArray'
          run_test!
        end
        response '401', '' do
          run_test!
        end
        response '404', '' do
          let(:id) { Time.zone.now.to_i }
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
          run_test!
        end
        response 500, 'Internal server error' do
          document_response_without_test!
        end
      end
    end
    post '' do
      security [Bearer: []]
      tags 'Messages' # 'kotlin']
      parameter name: :id, in: :path, type: :string
      parameter name: :"message[body]", in: :formData, type: :string

      let(:Authorization) { '' }
      let('message[body]') { Faker::Lorem.sentence }

      let(:message) { create(:message, room: create(:public_active_room)) }
      let(:room) { message.room }
      let(:id) { room.id }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        schema "$ref": '#/definitions/MessagesObject'
        before do |example|
          allow_any_instance_of(Message).to receive(:post).and_return(nil)

          submit_request(example.metadata)
        end

        it "returns a #{metadata[:response][:code]} response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        let(:id) { Time.zone.now.to_i }
        before do |example|
          allow_any_instance_of(Message).to receive(:post).and_return(nil)

          submit_request(example.metadata)
        end

        it "returns a #{metadata[:response][:code]} response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end

  path '/rooms/{room_id}/messages/{id}' do
    get '' do
      security [Bearer: []]
      tags 'Messages' # 'android-old']

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :room_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      let(:message) { create(:message, room: create(:public_active_room)) }
      let(:room) { message.room }
      let(:room_id) { room.id }
      let(:id) { message.id }
      let(:Authorization) { '' }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        schema "$ref": '#/definitions/MessagesObject'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        let(:id) { Time.zone.now.to_i }
        before do |example|
          allow_any_instance_of(Message).to receive(:delete_real_time).and_return(nil)

          submit_request(example.metadata)
        end

        it "returns a #{metadata[:response][:code]} response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
    delete '' do
      security [Bearer: []]
      tags 'Messages' # 'android-old']
      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :room_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      let(:message) { create(:message, room: create(:public_active_room)) }
      let(:room) { message.room }
      let(:room_id) { room.id }
      let(:id) { message.id }
      let(:Authorization) { '' }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        before do |example|
          allow_any_instance_of(Message).to receive(:delete_real_time).and_return(nil)
          submit_request(example.metadata)
        end

        it 'returns a 200 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:id) { (100 + message.id).to_i }

        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: message.person_id)}" }
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end
