# frozen_string_literal: true

FactoryBot.define do
  factory :program do
    long_name { "MyString" }
    short_name { "MyString" }
    description { "" }
    status { 1 }
    duration { 1 }
    is_completed { false }
    copyright_text { "" }
  end
end
