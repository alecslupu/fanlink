class AddMessageJsonResponse < Apigen::Migration
  def up
    add_model :message_response do
      type :object do
        id :string
        body :string
        create_time :datetime
        status :string?
        picture_url :string?
        audio_url :string?
        audio_size :string?
        audio_content_type :string?
        person :person_response
        mentions :array? do
          type :mention_response
        end
      end
    end

    add_model :message_list_response do
      type :object do
        id :string
        person_id :int32
        room_id :int32
        body :string
        hidden :bool
        picture_url :string?
        created_at :datetime
        updated_at :datetime
      end
    end
  end
end