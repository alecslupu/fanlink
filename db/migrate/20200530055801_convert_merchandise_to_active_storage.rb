class ConvertMerchandiseToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    Merchandise.where.not(picture_file_name: nil).find_each do |merchandise|
      Migration::Assets::MerchandiseJob.perform_later(merchandise.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
