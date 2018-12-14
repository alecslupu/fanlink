class AddAgeRequirementToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :age_requirement, :integer, default: 0
  end
end
