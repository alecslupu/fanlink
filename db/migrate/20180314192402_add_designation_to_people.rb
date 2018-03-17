class AddDesignationToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :designation, :jsonb, default: {}, null: false
  end
end
