class AddTypeToStaticContent < ActiveRecord::Migration[5.2]
  def change
    add_column :static_contents, :type, :string, default: "WebsiteStaticContent"
  end
end
