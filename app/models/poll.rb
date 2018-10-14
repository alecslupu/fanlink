class Poll < ApplicationRecord
  validates :poll_status, inclusion: { in: %w(active disabled) }, presence: true

  has_many :post_polls

  has_many :posts, through: :post_polls
end
