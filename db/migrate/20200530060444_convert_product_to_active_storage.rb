class ConvertProductToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    Product.where.not(logo_file_name: nil).find_each do |product|
      Migration::Assets::ProductJob.perform_later(product.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
