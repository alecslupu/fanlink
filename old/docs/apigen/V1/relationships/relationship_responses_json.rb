class AddRelationJsonResponse < Apigen::Migration
  def up
    add_model :relationship_response do
      type :object do
        id :string?
        requested_by :person_response?
        requested_to :person_response?
        status :string?
        created_time :string?
        updated_time :string?
      end
    end

    add_model :relationship_portal_response do
      type :object do
        id :string?
        requested_by :person_response?
        requested_to :person_response?
        status :string?
        created_at :string?
        updated_at :string?
      end
    end
  end
end
