class AddProductConfigurationFields < ActiveRecord::Migration[5.1]
  def change
    add_attachment :products, :logo
    add_column :products, :color_primary, :string, default: '#4B73D7'
    add_column :products, :color_primary_dark, :string, default: '#4B73D7'
    add_column :products, :color_primary_66, :string, default: '#A94B73D7'
    add_column :products, :color_primary_text, :string, default: '#FFFFFFF'
    add_column :products, :color_secondary, :string, default: '#CDE5FF'
    add_column :products, :color_secondary_text, :string, default: '#000000'
    add_column :products, :color_tertiary, :string, default: '#FFFFFF'
    add_column :products, :color_tertiary_text, :string, default: '#000000'
    add_column :products, :color_accent, :string, default: '#FFF537'
    add_column :products, :color_accent_50, :string, default: '#FFF537'
    add_column :products, :color_accent_text, :string, default: '#FFF537'
    add_column :products, :color_title_text, :string, default: '#FFF537'
    add_column :products, :navigation_bar_style, :integer, default: 1
    add_column :products, :status_bar_style, :integer, default: 1
    add_column :products, :toolbar_style, :integer, default: 1
  end
end
