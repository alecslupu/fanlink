# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id            :bigint           not null, primary key
#  product_id    :integer          not null
#  displayed_url :text             not null
#  protected     :boolean          default(FALSE)
#  deleted       :boolean          default(FALSE)
#

FactoryBot.define do
  factory :url do
    product { current_product }
    sequence(:displayed_url) { |n| "http://example.com/#{n}" }
  end
end
