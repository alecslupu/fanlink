class ChangeStaticContentFieldsType < ActiveRecord::Migration[5.1]
  def self.up
    change_column :static_contents, :content, :text, null: false
    change_column :static_contents, :title, :string, null: false
    change_column_default(:static_contents, :content, nil)
    change_column_default(:static_contents, :title, nil)
  end

  def self.down
    change_column :static_contents, :content, 'jsonb USING CAST(content AS jsonb)', default: {}, null: false
    change_column :static_contents, :title, 'jsonb USING CAST(title AS jsonb)', default: {}, null: false
  end
end

