class Poll < ApplicationRecord
  validates :poll_type, inclusion: {in: %w(post) }, presence: true
  validates :poll_status, inclusion: { in: %w(active disabled) }, presence: true

  belongs_to :post, foreign_key: "post_type_id", foreign_type: "post_type"
end
