# frozen_string_literal: true

# == Schema Information
#
# Table name: blocks
#
#  id         :bigint(8)        not null, primary key
#  blocker_id :integer          not null
#  blocked_id :integer          not null
#  created_at :datetime         not null
#

class Block < ApplicationRecord
  belongs_to :blocker, class_name: "Person", touch: true
  belongs_to :blocked, class_name: "Person", touch: true
  has_paper_trail ignore: [:created_at]

  validates :blocked_id, uniqueness: { scope: :blocker_id, message: _('That user is already blocked.') }
end
