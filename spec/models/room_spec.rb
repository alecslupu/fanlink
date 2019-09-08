RSpec.describe Room, type: :model do
  before(:all) do
    @name = "abc"
    @room = create(:room, name: @name, public: true)
    ActsAsTenant.current_tenant = @room.product
  end

  context "Associations" do
    describe "should belong to" do
      it "#created_by" do
        should belong_to(:created_by).class_name("Person")
      end

      it "#product" do
        should belong_to(:product)
      end
    end

    describe "should have many" do
      it "#courses" do
        should have_many(:room_memberships).dependent(:destroy)
      end

      it "#members" do
        should have_many(:members).through(:room_memberships)
      end

      it "#messages" do
        should have_many(:messages).dependent(:restrict_with_error)
      end
    end
  end

  context "Validation" do
    describe "should create a valid room" do
      it do
        expect(create(:room)).to be_valid
      end
    end
    describe "should not allow private rooms to have pictures" do
      it do
        room = build(:room, public: false, picture_file_name: "foo.jpg")
        expect(room).not_to be_valid
        expect(room.errors[:picture]).not_to be_empty
      end
    end
  end

  context "Methods" do
    describe "#destroy" do
      it "should not let you destroy a room that has messages" do
        create(:message, room: @room)
        @room.destroy
        expect(@room).to exist_in_database
      end
    end

    describe "#is_member?" do
      let(:member) { create(:person) }
      let(:non_member) { create(:person) }
      let(:room) { create(:room, public: false) }
      it "should return true for room member" do
        room.members << member
        expect(room.is_member?(member)).to be_truthy
      end
      it "should return false for non room member" do
        expect(room.is_member?(non_member)).to be_falsey
      end
    end
    describe "#private?" do
      pending
    end

    describe "#clear_message_counter" do
      it "responds to method" do
        expect(Room.new).to respond_to(:clear_message_counter)
      end
      pending
    end
    describe "#delete_me" do
      it "responds to method" do
        expect(Room.new).to respond_to(:delete_me)
      end
      pending
    end
    describe "#post" do
      it "responds to method" do
        expect(Room.new).to respond_to(:post)
      end
      pending
    end
    describe "#increment_message_counters" do
      it "responds to method" do
        expect(Room.new).to respond_to(:increment_message_counters)
      end
      pending
    end
    describe "#new_room" do
      it "responds to method" do
        expect(Room.new).to respond_to(:new_room)
      end
      pending
    end
  end

  context "Enumeration" do
    it "#should define status enumerables with values of inactive, active, and deleted" do
      should define_enum_for(:status).with([:inactive, :active, :deleted])
    end
  end

  # There is no validation currently in the model for these tests
  # describe "#name" do
  #   it "should accept a good name format" do
  #     room = build(:room, name: "My Room")
  #     expect(room).to be_valid
  #   end
  #   it "should not require name for private room" do
  #     room = build(:room, name: nil, public: false)
  #     expect(room).to be_valid
  #   end
  #   it "should not require name for public room" do
  #     room = build(:room, name: nil, public: true)
  #     expect(room).to be_valid
  #   end
  #   it "should require name for public room" do
  #     room = build(:room, name: nil, public: true)
  #     expect(room).to be_valid
  #   end
  # end
end
