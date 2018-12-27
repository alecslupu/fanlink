module Product::Views
  extend ActiveSupport::Concern
  included do

    api_accessible :product_v2 do |template|
      template.add :id
      template.add :name
      template.add :internal_name
    end

    api_accessible :product_v3, :extend => :product_v2 do |t|
    end

    api_accessible :product_v4, :extend => :product_v3 do |t|
    end


    api_accessible :product_v5, :extend => :product_v4 do |t|
    end

    api_accessible :product_v5_setup, :extend => :product_v5 do |template|
      template.add :logo_url
      template.add :color_primary
      template.add :color_primary_text
      template.add :color_primary_66
      template.add :color_primary_dark
      template.add :color_secondary
      template.add :color_tertiary
      template.add :color_tertiary_text
      template.add :color_accent
      template.add :color_accent_50
      template.add :color_accent_text
      template.add :color_title_text
    end
  end
end
