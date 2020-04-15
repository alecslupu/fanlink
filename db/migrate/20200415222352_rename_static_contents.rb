class RenameStaticContents < ActiveRecord::Migration[5.2]
  def change
    rename_table :static_contents, :static_web_contents
  end
end
