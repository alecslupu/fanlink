require "rails_helper"

RSpec.describe Api::V4::RoomsController, type: :controller do

  # TODO: auto-generated
  describe "GET index" do
   it 'should get a list of active public rooms in order based on activity' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        room1 = create(:room, public: true, status: :active)
        message_room1 =  msg = create(:message, person: person, room: room1)
        room2 = create(:room, public: true, status: :active)
        message_room1 =  msg = create(:message, person: person, room: room2)
        inactive_room = create(:room, public: true, status: :inactive)
        deleted_room = create(:room, public: true, status: :deleted)
        private_room = create(:room, public: false, status: :active, created_by: @person)
        private_room.room_memberships.create(person_id: person.id)
        # other_product_room = create(:room, public: true, status: :active, product: create(:product))

        get :index, params: { product: person.product}
        expect(response).to be_successful
        room_ids = json['rooms'].map { |r| r['id'] }
        expect(room_ids).to eq([room2.id.to_s, room1.id.to_s])
      end
    end
  end
  # TODO: auto-generated
  describe 'GET show' do
    pending
  end

  # TODO: auto-generated
  describe 'POST create' do
    pending
  end

  # TODO: auto-generated
  describe 'PUT update' do
    pending
  end
end
