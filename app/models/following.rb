# frozen_string_literal: true

# == Schema Information
#
# Table name: followings
#
#  id          :bigint(8)        not null, primary key
#  follower_id :integer          not null
#  followed_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Following < ApplicationRecord
  default_scope -> { order(Arel.sql 'followings.created_at DESC, followings.id DESC') }

  belongs_to :follower, class_name: 'Person', touch: true
  belongs_to :followed, class_name: 'Person', touch: true

  validates :followed_id, uniqueness: { scope: :follower_id, message: _('You are already following that person.') }
end
