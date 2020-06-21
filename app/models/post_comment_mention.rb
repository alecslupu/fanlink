# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comment_mentions
#
#  id              :bigint(8)        not null, primary key
#  post_comment_id :integer          not null
#  person_id       :integer          not null
#  location        :integer          default(0), not null
#  length          :integer          default(0), not null
#

class PostCommentMention < ApplicationRecord
  belongs_to :person, touch: true
  belongs_to :post_comment, touch: true
end
