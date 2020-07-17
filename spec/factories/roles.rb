# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id                     :bigint           not null, primary key
#  name                   :string           not null
#  internal_name          :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  post                   :integer          default(0), not null
#  chat                   :integer          default(0), not null
#  event                  :integer          default(0), not null
#  merchandise            :integer          default(0), not null
#  badge                  :integer          default(0), not null
#  reward                 :integer          default(0), not null
#  quest                  :integer          default(0), not null
#  beacon                 :integer          default(0), not null
#  reporting              :integer          default(0), not null
#  interest               :integer          default(0), not null
#  courseware             :integer          default(0), not null
#  trivia                 :integer          default(0), not null
#  admin                  :integer          default(0), not null
#  root                   :integer          default(0), not null
#  user                   :integer          default(0), not null
#  portal_notification    :integer          default(0), not null
#  automated_notification :integer          default(0), not null
#  marketing_notification :integer          default(0), not null
#

FactoryBot.define do
  factory :role do
    name { Faker::Lorem.word }
    internal_name { Faker::Lorem.word }

    factory :role_admin do
      name { 'admin' }
      internal_name { 'admin' }
    end

    factory :role_normal do
      internal_name { 'normal' }
    end

    factory :role_super_admin do
      name { 'super_admin' }
      internal_name { 'super_admin' }
    end

    factory :role_client do
      name { 'client' }
      internal_name { 'client' }
    end
  end
end
