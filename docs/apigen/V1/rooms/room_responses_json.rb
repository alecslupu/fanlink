class AddRoomJsonResponse < Apigen::Migration
  def up
    add_model :room_response do
      type :object do
        id :int32?
        owned :bool?
        public :bool?
        picture_url :string?
        name :string?
        description :string?
        members :array? do
          type :person_response
        end
      end
    end

    add_model :room_portal_response do
      type :object do
        id :int32?
        owned :bool?
        public :bool?
        picture_url :string?
        name :string?
        description :string?
        members :array? do
          type :person_response
        end
      end
    end
  end
end