# frozen_string_literal: true

# == Schema Information
#
# Table name: static_system_emails
#
#  id         :bigint           not null, primary key
#  name       :string
#  product_id :bigint
#  public     :boolean          default(FALSE)
#  from_name  :string
#  from_email :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


FactoryBot.define do
  factory :static_system_email, class: 'Static::SystemEmail' do
    name  { Faker::Lorem.sentence }
    product { current_product }
    html_template { Faker::Lorem.paragraph }
    text_template { Faker::Lorem.paragraph }
    sequence(:public) { true }
    subject { Faker::Lorem.sentence }
  end
end
