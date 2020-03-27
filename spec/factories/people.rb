# == Schema Information
#
# Table name: people
#
#  id                              :bigint(8)        not null, primary key
#  username                        :text             not null
#  username_canonical              :text             not null
#  email                           :text
#  name                            :text
#  product_id                      :integer          not null
#  crypted_password                :text
#  salt                            :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  facebookid                      :text
#  facebook_picture_url            :text
#  picture_file_name               :string
#  picture_content_type            :string
#  picture_file_size               :integer
#  picture_updated_at              :datetime
#  do_not_message_me               :boolean          default(FALSE), not null
#  pin_messages_from               :boolean          default(FALSE), not null
#  auto_follow                     :boolean          default(FALSE), not null
#  old_role                        :integer          default("normal"), not null
#  reset_password_token            :text
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  product_account                 :boolean          default(FALSE), not null
#  chat_banned                     :boolean          default(FALSE), not null
#  recommended                     :boolean          default(FALSE), not null
#  designation                     :jsonb            not null
#  gender                          :integer          default("unspecified"), not null
#  birthdate                       :date
#  city                            :text
#  country_code                    :text
#  biography                       :text
#  tester                          :boolean          default(FALSE)
#  terminated                      :boolean          default(FALSE)
#  terminated_reason               :text
#  deleted                         :boolean          default(FALSE)
#  role_id                         :bigint(8)
#  authorized                      :boolean          default(TRUE), not null
#

require "faker"

FactoryBot.define do
  factory :person do
    product { current_product }
    sequence(:username) { |n| "person#{n}" }
    sequence(:email) { "#{username}@example.com" }
    name { Faker::Name.name }
    password { "badpassword" }
    birthdate { "2000-01-01" }
    country_code { "US" }
    # city { "Bucharest" }
    # biography { Faker::Lorem.paragraph(sentence_count: 2)}
    # picture { File.open("#{Rails.root}/spec/fixtures/images/large.jpg") }

    role { Role.where(internal_name: 'normal').first || create(:role_normal) }

    factory :recommended_person do
      recommended { true }
    end

    factory :admin_user do
      role { Role.where(internal_name: 'admin').first || create(:role_admin) }
    end

    factory :client_user do
      role { Role.where(internal_name: 'client').first || create(:role_client) }
    end

    factory :super_admin do
      role { Role.where(internal_name: 'super_admin').first || create(:role_super_admin) }
    end
  end
end
