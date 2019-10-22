product = Product.create!(
  name: "Can Ed", internal_name: "caned",  enabled: true,  can_have_supers: true,  age_requirement: 21,
  # logo_file_name: nil, logo_content_type: nil,  logo_file_size: nil,  logo_updated_at: nil,
  color_primary: "4B73D7", color_primary_text: "FFFFFF", color_secondary: "CDE5FF", color_secondary_text: "000000",
  color_tertiary: "FFFFFF", color_tertiary_text: "000000", color_accent: "FFF537", color_accent_text: "FFF537",
  color_title_text: "FFF537", color_accessory: "000000", navigation_bar_style: 1, status_bar_style: 1, toolbar_style: 1,
  features: 0, contact_email: "onions@onions.onions.", privacy_url: "http://onions.com/privacy",
  terms_url: "http://onions.com/lterms", android_url: "http://playstore.link", ios_url: "http:/appstore.link"
)

Person.create!(
  name: "Admin User", username: "admin", product_id: product.id, birthdate: "1982-01-01", role: :super_admin,
  email: "admin+#{product.internal_name}@flink.to", password: "flink_admin"
)
Person.create!(
  name: "CustomerSupport", username: "CustomerSupport", product_id: product.id, birthdate: "1982-01-01", role: :staff,
  email: "customersupport+#{product.internal_name}@can-ed.com", password: "#{product.internal_name}_CustomerSupport"
)
# ==========================================

ActsAsTenant.with_tenant(product) do
  require "seeds/action_type"
  require "seeds/badge"
  require "seeds/reward"
  require "seeds/assigned_reward"
end
