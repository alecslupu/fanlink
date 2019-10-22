class AddIndexToStaticContent < ActiveRecord::Migration[5.1]
  def self.up
    unless index_exists?(:static_contents, :slug,  unique: true)
      add_index :static_contents, :slug, unique: true
    end
  end
  def self.down
    remove_index :static_contents, :slug
  end
end
