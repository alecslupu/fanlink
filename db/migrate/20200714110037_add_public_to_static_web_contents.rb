class AddPublicToStaticWebContents < ActiveRecord::Migration[6.0]
  def change
    add_column :static_web_contents, :public, :boolean, default: false
  end
end
