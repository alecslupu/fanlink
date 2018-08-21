class SetProductAgeRequirement < ActiveRecord::Migration[5.1]
  def change
    Product.all.each do |product|
      product.age_requirement = 13
      product.save!
    end
  end
end
