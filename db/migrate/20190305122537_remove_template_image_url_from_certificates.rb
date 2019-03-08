class RemoveTemplateImageUrlFromCertificates < ActiveRecord::Migration[5.1]
  def up
  	remove_column :certificates, :template_image_url
  end

  def down
  	add_column :certificates, :template_image_url, :string
  end
end