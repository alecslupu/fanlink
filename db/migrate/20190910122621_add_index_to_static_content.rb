class AddIndexToStaticContent < ActiveRecord::Migration[5.1]
  def change
    add_index :static_contents, :slug, unique: true
  end
end
