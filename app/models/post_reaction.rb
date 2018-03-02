class PostReaction < ApplicationRecord
  belongs_to :post
  belongs_to :person

  has_paper_trail

  validate :check_emoji
  validates :person, uniqueness: { scope: :post, message: "You have already reacted to this post." }
  validates :reaction, presence: { message: "Reaction is required." }

private

  def check_emoji
    bottom = 0x1F600
    top = 0x1F64F
    hex_val = reaction.to_i(16)
    if hex_val < bottom || hex_val > top
      errors.add(:reaction, "Reaction is not a valid value.")
    end
  end
end
