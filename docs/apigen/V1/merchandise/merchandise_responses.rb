class AddMerchandiseJsonResponse < Apigen::Migration
  def up
    add_model :merchandise_response do
        type :object do
          id :string?
          name :string?
          description :string?
          price :string?
          purchase_url :string?
          picture_url :string?
          available :bool?
          priority :int32?
        end
    end
  end
end
