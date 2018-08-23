require 'swagger_helper'

RSpec.describe 'api/v3/quests', type: :request do
  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @admin = create(:person, role: :admin, product: @product)
    ActsAsTenant.current_tenant = @person.product
  end

  after(:each) do
    logout
  end

  path '/quests' do
    get "Get all visible quests" do
      produces 'application/json'
      response(200, "Sucessfully retrieved quests") do
        let(:quests) do
          3.times do
            create(:quest, product: @product)
          end
        end
        before do |example|
          login_as(@person)
          submit_request(example.metadata)
        end
        it 'returns a valid 200 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
    post "Creates a quest" do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          quest: {
            type: :object,
            properties: {
              name: { type: :string },
              internal_name: { type: :string },
              description: { type: :string },
              status: { type: :string },
              starts_at: { type: :string },
              ends_at: { type: :string }
            }
          }
        },
        required: [ "name", "internal_name", "description", "starts_at" ]
      }
      response(200, "Quest created") do
        let(:params) {
          {
            quest:
            {
              name: "Don't get caught", 
              internal_name: "national_treasure" ,
              description: "Steal the Declaration of Independence",
              status: "enabled",
              starts_at: "1776-07-04T10:22:08Z",
              ends_at: "2019-11-19T10:22:08Z"
            }
          }
        }
        before do |example|
          login_as(@admin)
          submit_request(example.metadata)
        end
        it "returns a valid 200 response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/quests/{id}' do
    parameter name: :id, :in => :path, :type => :string
    get(summary: 'show quest') do
      produces 'application/json'
      response(200, "Sucessfully retrieved quest") do
        let(:id) { create(:quest, product: @product).id }
        before do |example|
          login_as(@admin)
          submit_request(example.metadata)
        end
        it "returns a valid 200 response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
    patch(summary: 'update quest') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          quest: {
            type: :object,
            properties: {
              name: { type: :string },
              internal_name: { type: :string },
              description: { type: :string },
              status: { type: :string },
              starts_at: { type: :string },
              ends_at: { type: :string }
            }
          }
        }
      }
      response(200, "Sucessfully updated quest {PATCH}") do
        let(:id) { create(:quest, product: @product).id }
        let(:params) {
          {
            quest:
            {
              name: "Got caught."
            }
          }
        }
        before do |example|
          login_as(@admin)
          submit_request(example.metadata)
        end
        it "returns a valid 200 response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
    put(summary: 'update quest') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          quest: {
            type: :object,
            properties: {
              name: { type: :string },
              internal_name: { type: :string },
              description: { type: :string },
              status: { type: :string },
              starts_at: { type: :string },
              ends_at: { type: :string }
            }
          }
        }
      }
      response(200, "Sucessfully updated quest {PUT}") do
        let(:id) { create(:quest, product: @product).id }
        let(:params) {
          {
            quest:
            {
              name: "Got caught."
            }
          }
        }
        before do |example|
          login_as(@admin)
          submit_request(example.metadata)
        end
        it "returns a valid 200 response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
    delete(summary: 'delete quest') do
      response(200, "Sucessfully deleted quest") do
        let(:id) { create(:quest, product: @product).id }
        before do |example|
          login_as(@admin)
          submit_request(example.metadata)
        end
        it "returns a valid 200 response" do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/quests/list' do
    get(summary: 'list quest') do
      produces 'application/json'
      response(200, "Sucessfully retrieved quests") do
        let(:quests) do
          3.times do
            create(:quest, product: @product)
          end
        end
        before do |example|
          login_as(@admin)
          submit_request(example.metadata)
        end
        it 'returns a valid 200 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  path '/quests/select' do
    get(summary: 'list quests') do
      produces 'application/json'
      response(200, "Sucessfully retrieved quests") do
        let(:quests) do
          3.times do
            create(:quest, product: @product)
          end
        end
        before do |example|
          login_as(@person)
          submit_request(example.metadata)
        end
        it 'returns a valid 200 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
