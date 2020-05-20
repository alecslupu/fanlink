# frozen_string_literal: true
# == Schema Information
#
# Table name: products
#
#  id                   :bigint(8)        not null, primary key
#  name                 :string           not null
#  internal_name        :string           not null
#  enabled              :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  can_have_supers      :boolean          default(FALSE), not null
#  age_requirement      :integer          default(0)
#  logo_file_name       :string
#  logo_content_type    :string
#  logo_file_size       :integer
#  logo_updated_at      :datetime
#  color_primary        :string           default("4B73D7")
#  color_primary_text   :string           default("FFFFFF")
#  color_secondary      :string           default("CDE5FF")
#  color_secondary_text :string           default("000000")
#  color_tertiary       :string           default("FFFFFF")
#  color_tertiary_text  :string           default("000000")
#  color_accent         :string           default("FFF537")
#  color_accent_text    :string           default("FFF537")
#  color_title_text     :string           default("FFF537")
#  color_accessory      :string           default("000000")
#  navigation_bar_style :integer          default(1)
#  status_bar_style     :integer          default(1)
#  toolbar_style        :integer          default(1)
#  features             :integer          default(0), not null
#  contact_email        :string
#  privacy_url          :text
#  terms_url            :text
#  android_url          :text
#  ios_url              :text
#

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    sequence(:internal_name) { |n| "product#{n}" }
    enabled { true }
  end
end
