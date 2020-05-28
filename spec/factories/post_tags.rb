# frozen_string_literal: true
# == Schema Information
#
# Table name: post_tags
#
#  post_id :bigint(8)        not null
#  tag_id  :bigint(8)        not null
#

FactoryBot.define do
  factory :post_tag do
    post { create(:post) }
    tag { create(:tag) }
  end
end
