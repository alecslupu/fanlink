class ChangeStaticContent < ActiveRecord::Migration[5.1]
  def self.up
    change_column :static_contents, :content, :jsonb, default: '{}', null: false, using: "content::jsonb"
    change_column :static_contents, :title, :jsonb, default: '{}', null: false, using: "content::jsonb"
  end
  def self.down
    change_column :static_contents, :content, :text, default: "", null: false
    change_column :static_contents, :title, :string, default: "", null: false
  end
end
