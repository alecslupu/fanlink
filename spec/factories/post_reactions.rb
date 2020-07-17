# frozen_string_literal: true

# == Schema Information
#
# Table name: post_reactions
#
#  id        :bigint           not null, primary key
#  post_id   :integer          not null
#  person_id :integer          not null
#  reaction  :text             not null
#

require 'faker'

FactoryBot.define do
  factory :post_reaction do
    person { create(:person) }
    post { create(:post) }
    reaction { %w[1F600 1F601 1F602].sample }
  end
end
