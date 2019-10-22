class Addactivity_typeJsonResponse < Apigen::Migration
  def up
    add_model :activity_type_response do
      type :object do
          id :int32
          activity_id :int32
          value :object
          deleted :bool
          created_at :datetime
          updated_at :datetime
          atype :int32
      end
    end
  end
end