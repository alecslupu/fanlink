# frozen_string_literal: true
# == Schema Information
#
# Table name: post_tags
#
#  post_id :bigint(8)        not null
#  tag_id  :bigint(8)        not null
#

class PostTag < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :tag
end
