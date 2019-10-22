class AddEventJsonResponse < Apigen::Migration
  def up
    add_model :event_response do
      type :object do
        id :string?
        name :string?
        description :string?
        starts_at :string?
        ends_at :string?
        ticket_url :string?
        place_identifier :string?
        deleted :bool?
      end
    end
  end
end